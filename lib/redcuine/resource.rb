module Redcuine
  module Resource
    class Base < ActiveResource::Base
      def self.setup(&block)
        instance_eval &block
      end
    end

    class Issue < Base
    end

    class Project < Base
    end
  end
end
