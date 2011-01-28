require 'rubygems'
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
                                          $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/smtp'
require 'nkf'
require 'yaml'
require 'time'
require "ostruct"
require "optparse"
require "yaml"

require "redticket/config_setup"
require "redticket/optparser"
require "redticket/mail"
require "redticket/mail_sender"

Version = File.read(File.join(File.dirname(__FILE__), '../VERSION')).strip
module Redticket
  CONFIG = OptParser.parse!(ARGV)
  CONF_DIR = File.expand_path('~/.redticket') unless defined? CONF_DIR
  CONF_FILE = File.join(Redticket::CONF_DIR, 'config.yml') unless defined? CONF_FILE

  def self.load_config!
    ConfigSetup.run
    yaml = YAML.load(IO.read(CONF_FILE))
    yaml.each do |k, v|
      CONFIG.send("#{k}=", v) unless CONFIG.send(k)
    end
  end
  load_config!
end
