module ActiveResource
  class Connection
    def request_with_print(method, path, *arguments)
      puts "#{method.to_s.upcase} #{site.scheme}://#{site.host}:#{site.port}#{path}"
      res = request_without_print(method, path, *arguments)
      puts res if Redcuine::CONFIG["debug"]
      return res
    end
    alias_method_chain :request, :print
  end
end
