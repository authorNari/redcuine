module Redcuine
  class Base
    def self.run
      if res = check_args
        Resource::Base.setup do
          self.site = CONFIG["site"]
          if CONFIG["user"] && CONFIG["password"]
            self.user = CONFIG["user"]
            self.password = CONFIG["password"]
          end
        end
      end
      return res
    end

    private
    def rest_options(keys, default={})
      params = {}
      keys.each do |k|
        params[k] = CONFIG[k.to_s]
      end
      params = default.merge(params)
      params.delete_if{|_, v| v.nil?}
      return params
    end

    def self.check_args
      unless CONFIG["site"]
        puts "Please set --site."
        return false
      end
      return true
    end
  end
end
