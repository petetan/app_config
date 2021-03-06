require 'spec_helper'

describe AppConfig do

  it 'has a version' do
    AppConfig::VERSION.should_not be_nil
  end

  it 'responds to .setup!()' do
    AppConfig.should respond_to(:setup!)
  end

  it 'responds to .setup?()' do
    AppConfig.should respond_to(:setup?)
  end

  it 'responds to .reset!()' do
    AppConfig.should respond_to(:reset!)
  end

  it 'should have to_hash' do
    config_for_yaml
    AppConfig.to_hash.class.should == Hash
  end

  it 'should reset @@storage' do
    # configure first
    config_for_yaml
    # then reset
    AppConfig.reset!
    AppConfig.send(:storage).should be_nil
  end

  it 'to_hash() returns an empty hash if storage not set' do
    AppConfig.reset!
    AppConfig.to_hash.should == {}
  end

  it 'should not be setup' do
    AppConfig.reset!
    AppConfig.should_not be_setup
  end

  it 'should be setup' do
    config_for_yaml
    AppConfig.should be_setup
  end

  it 'returns a Hash on setup' do
    AppConfig.reset!
    config = AppConfig.setup! do |c|
      c.name = 'Dale'
      c.nick = 'Oshuma'
    end
    config.should be_instance_of(Hash)
  end

  it 'raises NotSetup if .storage is accessed and .setup! has not been called' do
    AppConfig.remove_class_variable(:@@storage)

    lambda do
      AppConfig.save!
    end.should raise_error(AppConfig::Error::NotSetup)
  end

end
