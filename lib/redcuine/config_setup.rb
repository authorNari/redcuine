# -*- coding: utf-8 -*-
require 'erb'

module Redcuine
  module ConfigSetup
    module_function

    def run
      unless File.exists?(CONF_DIR)
        template = open(File.dirname(__FILE__) + '/config_template.erb').read
        config = ERB.new(template, nil, '-').result(binding)
        Dir.mkdir(CONF_DIR)
        File.open(CONF_FILE, 'w', 0600) {|io|
          io << config
        }

        puts "generated: ~/.redcuine/config.yml"
        puts "Please setup it."
        exit
      end
    end
  end
end
