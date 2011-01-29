module Redcuine
  class Issue < Base
    @@default_param = {}
    @@issue_attribute_keys = [:subject, :description, :tracker_id, :status_id,
                              :category_id, :assigned_to, :priority, :fixed_version,
                              :start_date, :due_date, :estimate_date, :done_ratio]

    def self.run
      if super
        @@default_param = {:key => CONFIG["api_key"]} if CONFIG["enable_api_key"]
        return self.send(CONFIG['rest_type'])
      end
      return false
    end

    def self.get
      CONFIG["id"] ? show(CONFIG["id"]) : index
    rescue
      puts $!.to_s
      puts $!.backtrace if CONFIG["debug"]
      puts "Fail to get issue."
      return false
    end

    def self.post
      keys = [:project_id] + @@issue_attribute_keys
      opts = rest_options(keys, @@default_param)
      issue = Resource::Issue.new(opts)
      res = issue.save
      puts res ? "Created issue!" : "Fail to create issue."
      return res
    rescue
      puts $!.to_s
      puts $!.backtrace if CONFIG["debug"]
      puts "Fail to create issue."
      return false
    end

    def self.put
      keys = @@issue_attribute_keys
      opts = rest_options(keys, @@default_param)
      issue = Resource::Issue.find(CONFIG["id"])
      issue.load(opts)
      res = issue.save
      puts res ? "Updated issue!" : "Fail to update issue."
      return res
    rescue
      puts $!.to_s
      puts $!.backtrace if CONFIG["debug"]
      puts "Fail to update issue."
      return false
    end

    def self.delete
      issue = Resource::Issue.find(CONFIG["id"])
      res = issue.destroy
      puts res ? "Destroyed issue!" : "Fail to destroy issue."
      return res
    rescue
      puts $!.to_s
      puts $!.backtrace if CONFIG["debug"]
      puts "Fail to destroy issue."
      return false
    end

    private
    def self.check_args
      return false unless super
      unless CONFIG['rest_type']
        puts "Please input -g or -u or -p -or -d."
        return false
      end
      if (CONFIG['rest_type'] == :put || CONFIG['rest_type'] == :delete) &&
          !CONFIG['id']
        puts "Please input --id."
        return false
      end
      if CONFIG['rest_type'] == :post && CONFIG['project_id'].blank?
        puts "Please input --project-id."
        return false
      end
      return true
    end

    def self.show(id)
      issue = Resource::Issue.find(CONFIG["id"], :params => @@default_param)
      print_get_format(issue)
      return true
    end

    def self.index
      opts = rest_options([:project_id, :tracker_id, :assigned_to, :status_id],
                          @@default_param)
      res = Resource::Issue.find(:all, :params => opts)
      res.each {|issue| print_get_format(issue)} if res
      return true
    end

    def self.print_get_format(issue)
      puts "- id: #{issue.id}"
      %w(project status priority author assigned_to fixed_version).each do |k|
        if issue.respond_to?(k)
          puts "  #{k}: #{issue.send(k).name}, id:#{issue.send(k).id}"
        end
      end
      %w(subject description start_date due_date
         done_ratio estimated_hours created_on updated_on).each do |k|
        puts "  #{k}: #{issue.send(k)}" if issue.respond_to?(k)
      end
      if issue.respond_to?(:custom_fields)
        puts "  custom_fields: "
        issue.custom_fields.each do |cf|
          puts "   - #{cf.name}, id:#{cf.id}, value:#{cf.value}"
        end
      end
    end
  end
end
