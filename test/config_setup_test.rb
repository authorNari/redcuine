require "test_helper"

class ConfigSetupTest < Test::Unit::TestCase
  def test_run
    assert_equal false, Redcuine::ConfigSetup.run
    assert_equal true, File.exist?(Redcuine::CONF_FILE)
    assert_equal true, Redcuine::ConfigSetup.run
  end
end
