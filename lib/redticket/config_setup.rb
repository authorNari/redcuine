# -*- coding: utf-8 -*-
require 'erb'

module Redticket
  module ConfigSetup
    module_function

    def run
      unless File.exists?(Redticket::CONF_DIR)
        template = open(File.dirname(__FILE__) + '/config_template.erb').read
        config = ERB.new(template, nil, '-').result(binding)
        Dir.mkdir(Redticket::CONF_DIR)
        File.open(Redticket::CONF_FILE, 'w', 0600) {|io|
          io << config
        }

        puts "generated: ~/.redticket/config.yml"
        puts "Please setup it."
        exit
      end
    end
  end
end
