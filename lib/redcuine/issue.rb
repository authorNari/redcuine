module Redcuine
  class Issue < Base
    def self.run
      if super
        issue = self.new
        return issue.send(CONFIG['rest_type'])
      end
      return false
    end

    def initialize
      if CONFIG["enable_api_key"]
        @default_param = {:key => CONFIG["api_key"]}
      else
        @default_param = {}
      end
    end

    def get
      if CONFIG["id"]
        puts RedmineClient::Issue.find(CONFIG["id"], :params => @default_param).to_yaml
      else
        opts = rest_options([:project_id, :tracker_id, :assigned_to, :status_id],
                            @default_param)
        puts RedmineClient::Issue.find(:all, :params => opts).to_yaml
      end
      return true
    end

    def post
      keys = [:project_id, :subject, :describe, :tracker_id, :status_id,
              :category_id, :assigned_to, :priority, :fixed_version,
              :start_date, :due_date, :estimate_date, :done_ratio]
      opts = rest_options(keys, @default_param)
      issue = RedmineClient::Issue.new(opts)
      res = issue.save
      puts res ? "Issue created!" : "Issue fail to create."
      return res
    end

    def put
      keys = [:subject, :describe, :tracker_id, :status_id,
              :category_id, :assigned_to, :priority, :fixed_version,
              :start_date, :due_date, :estimate_date, :done_ratio]
      opts = rest_options(keys, @default_param)
      issue = RedmineClient::Issue.find(CONFIG["id"])
      issue.load(opts)
      res = issue.save
      puts res ? "Issue updated!" : "Issue fail to update."
      return res
    end

    def delete
      issue = RedmineClient::Issue.find(CONFIG["id"])
      res = issue.destroy
      puts res ? "Issue destroyed!" : "Issue fail to destroy."
      return res
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
      if CONFIG['rest_type'] == :post && CONFIG['project_id']
        puts "Please input --project-id."
        return false
      end
      return true
    end
  end
end
