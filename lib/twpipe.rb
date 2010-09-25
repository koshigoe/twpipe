require 'rubygems'
require 'twitter'
require 'twpipe/version'

# == Twpipe
#
class Twpipe
  MAX_TWEET_LENGTH = 140

  class ConfigError < Exception; end

  class << self
    # config_path:: the file path to configuration file
    attr_accessor :config_path
  end

  unless instance_variable_defined?(:@config_path)
    @config_path = File.expand_path('~/.twpipe')
  end

  # client:: twitter client that authenticated by oAuth (Twitter::Base)
  attr_reader :client

  def initialize
    setup_config
    setup_client
  end

  # tweet your message
  #
  # message: string variable that you would tweet
  #
  # return:
  # * message that truncated first MAX_TWEET_LENGTH characters
  #
  def tweet(message)
    @client.update(message)
    message.split(//).first(MAX_TWEET_LENGTH).join
  end

private

  def manual_of_configuration
    @manual_of_configuration ||=<<EOF
  - You must create configuration file which must set to "~/.twpipe".
  - The format of configuration file must be YAML.
  - Required configurations are:
    ctoken:: consumer token
    csecret:: consumer secret
    atoken:: access token
    asecret:: access secret
  - Optional configurations are:
    name:: your name at twitter
  - If you would get more informations of configurations:
    % grep config bin/twpipe
EOF
  end

  # required items of configuration
  #
  # ctoken:: consumer token
  # csecret:: consumer secret
  # atoken:: access token
  # asecret:: access secret
  #
  def required_items_of_configuration
    @required_items_of_configuration ||= %w(ctoken csecret atoken asecret).sort
  end

  def setup_config # :nodoc:
    unless File.exist?(self.class.config_path)
      raise ConfigError,
        "Configuration file not found, see following messages:\n\n" \
        "#{manual_of_configuration}"

    end

    begin
      @config = YAML.load_file(self.class.config_path)
    rescue
      raise ConfigError,
        "Configuration file was invalid, see following messages:\n\n" \
        "#{manual_of_configuration}"
    end

    if (@config.keys & required_items_of_configuration).sort != required_items_of_configuration
      raise ConfigError,
        "Some items of configuration not found, see following messages:\n\n" \
        "#{manual_of_configuration}"
    end
  end

  def setup_client
    oauth = Twitter::OAuth.new(@config['ctoken'], @config['csecret'])
    oauth.authorize_from_access(@config['atoken'], @config['asecret'])
    @client = Twitter::Base.new(oauth)
  end
end
