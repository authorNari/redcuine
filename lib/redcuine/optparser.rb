module Redcuine
  module OptParser
    def self.issue_parse!(argv)
      @issue_optionparser.parse!(argv)
    end

    private
    def self.default_opts(opt)
      opt.on('-p', '--post', 'POST by REST API') do
        CONFIG["rest_type"] = :post
      end

      opt.on('-g', '--get', 'GET by REST API') do |val|
        CONFIG["rest_type"] = :get
      end

      opt.on('-u', '--put', 'PUT by REST API') do |val|
        CONFIG["rest_type"] = :put
      end

      opt.on('-d', '--delete', 'DELETE by REST API') do |val|
        CONFIG["rest_type"] = :delete
      end

      opt.on('-s val', '--subject val', 'Set subject') do |val|
        CONFIG["subject"] = val
      end

      opt.on('-m val', '--description val', 'Set description') do |val|
        CONFIG["description"] = val
      end

      opt.on('-e [editor]', 'Edit description by editor (default $EDITOR || vi)') do |val|
        if val
          CONFIG["editor"] = val
        else
          CONFIG["editor"] = ENV['EDITOR'] || "vi"
        end
      end

      opt.on('--debug', 'for debug') do |val|
        CONFIG["debug"] = true
      end
    end

    @issue_optionparser = OptionParser.new do |opt|
      opt.program_name = 'redissue'

      default_opts(opt)
      %w(id tracker-id status-id category-id assigned-to-id
         priority-id fixed-version start-date due-date estimate-date
         done-ratio site project-id).each do |k|
        src = <<-SRC
        opt.on('--#{k} val', 'Set #{k.gsub("-", " ")}') do |val|
          CONFIG["#{k.gsub("-", "_")}"] = val
        end
        SRC
        eval(src)
      end
    end
  end
end
