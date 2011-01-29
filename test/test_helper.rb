require "test/unit"
require "tmpdir"
require "rr"

module Redcuine
  CONF_DIR = Dir.tmpdir
  CONF_FILE = File.join(Redcuine::CONF_DIR, '__recuine_test__config.yml')
end
require "redcuine"

class Test::Unit::TestCase
  def setup
    super
    setup_with_clear_config
  end

  def teardown
    super
    FileUtils.rm(Redcuine::CONF_FILE) if File.exist?(Redcuine::CONF_FILE)
  end

  def setup_with_clear_config
    Redcuine::CONFIG.clear
  end

  include RR::Adapters::RRMethods
end
