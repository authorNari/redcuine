module Redticket
  module OptParser
    def self.parse!(argv)
      @config = OpenStruct.new
      @optionparser.parse!(argv)
      return @config
    end

    @optionparser = OptionParser.new do |opt|
      opt.program_name = 'redticket'

      opt.on('--subject subject', 'Set subject') do |val|
        @config.subject = val
      end

      opt.on('--body body', 'Set body') do |val|
        @config.body = val
      end

      opt.on('--project name', 'Set project') do |val|
        @config.project = val
      end

      opt.on('--tracker name', 'Set tracker') do |val|
        @config.tracker = val
      end

      opt.on('--status name', 'Set status') do |val|
        @config.tracker = val
      end

      opt.on('--category name', 'Set category') do |val|
        @config.category = val
      end

      opt.on('--assigned-to address', 'Set assigned_to') do |val|
        @config.assigned_to = val
      end

      opt.on('--priority priority', 'Set priority') do |val|
        @config.priority = val
      end

      opt.on('--fixed-version version', 'Set fixed version') do |val|
        @config.fixed_version = val
      end

      opt.on('--start-date date', 'Set start date') do |val|
        @config.start_date = val
      end

      opt.on('--due-date date', 'Set due date') do |val|
        @config.start_date = val
      end

      opt.on('--estimate-date date', 'Set estimate date') do |val|
        @config.start_date = val
      end

      opt.on('--done-ratio ratio', 'Set done ratio') do |val|
        @config.done_ratio
      end

      opt.on('--to-address to', 'Set to address') do |val|
        @config.to_address = val
      end

      opt.on('--config-file file', 'Set path to configfile') do |val|
        Redticket::CONF_FILE = val
      end

      opt.on('--config-directory directory', 'Set redticket config directory') do |val|
        Redticket::CONF_DIR = val
      end

      opt.on('--dry-run', 'Print plane text of mail(Don\'t send mail). For debug') do |val|
        @config.dry_run = val
      end
    end
  end
end
