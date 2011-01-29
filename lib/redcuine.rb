require 'rubygems'
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
                                          $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'yaml'
require 'time'
require "ostruct"
require "optparse"
require 'active_resource'

require "redcuine/config_setup"
require "redcuine/optparser"
require "redcuine/base"
require "redcuine/issue"
require "redcuine/resource"
require "redcuine/active_resource_ext"

Version = File.read(File.join(File.dirname(__FILE__), '../VERSION')).strip
module Redcuine
  CONFIG = {}
  CONF_DIR = File.expand_path('~/.redcuine') unless defined? CONF_DIR
  CONF_FILE = File.join(Redcuine::CONF_DIR, 'config.yml') unless defined? CONF_FILE

  def self.load_config!
    ConfigSetup.run
    CONFIG.replace(YAML.load(IO.read(CONF_FILE)))
  end
  load_config!
end
