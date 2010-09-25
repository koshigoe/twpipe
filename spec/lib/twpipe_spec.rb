require 'tempfile'
require 'twpipe'

describe Twpipe do
  after do
    Twpipe.config_path = '~/.twpipe'
  end

  describe 'utilities' do
    describe 'config_path' do
      it 'should be equal "~/.twpipe" at default' do
        Twpipe.config_path.should == File.expand_path('~/.twpipe')
      end

      it 'should be able to change value' do
        Twpipe.config_path = 'hoge'
        Twpipe.config_path.should == 'hoge'
      end
    end
  end

  describe 'initialize' do
    let(:manual) do
      <<EOF
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

    it 'should raise error, if not exist specified configure file' do
      message = "Configuration file not found, see following messages:\n\n#{manual}"
      lambda { Twpipe.new }.should raise_error(Twpipe::ConfigError, message)
    end

    it 'should raise error, if configuration format was invalid' do
      Twpipe.config_path = File.join(File.dirname(__FILE__), '../data/config/syntax_error.yml')

      message = "Configuration file was invalid, see following messages:\n\n#{manual}"
      lambda { Twpipe.new }.should raise_error(Twpipe::ConfigError, message)
    end

    it 'should raise error, if not enough required items of configuration' do
      Twpipe.config_path = File.join(File.dirname(__FILE__), '../data/config/invalid.yml')

      message = "Some items of configuration not found, see following messages:\n\n#{manual}"
      lambda { Twpipe.new }.should raise_error(Twpipe::ConfigError, message)
    end

    it 'should not raise error, if configuration is valid' do
      Twpipe.config_path = File.join(File.dirname(__FILE__), '../data/config/valid.yml')
      twpipe = nil
      lambda { twpipe = Twpipe.new }.should_not raise_error
      twpipe.client.should be_an_instance_of Twitter::Base
    end
  end

  describe 'tweet' do
    let(:twitter) { mock('Twitter:Base') }

    it 'should receive Twitter::Base#update' do
      message = 'a' * 141
      Twpipe.config_path = File.join(File.dirname(__FILE__), '../data/config/valid.yml')
      twpipe = Twpipe.new
      twpipe.instance_variable_get(:@client).should_receive(:update).with(message)
      twpipe.tweet(message).should == 'a' * 140
    end
  end
end
