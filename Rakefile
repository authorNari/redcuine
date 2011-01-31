begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "redcuine"
    gemspec.summary = "CUI toolkit for Redmine"
    gemspec.email = "authornari@gmail.com"
    gemspec.homepage = "https://github.com/authorNari/redcuine"
    gemspec.description = "CUI toolkit for Redmine"
    gemspec.authors = ["Narihiro Nakmaura"]
    gemspec.add_dependency("activeresource", ">= 3.0.3")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "lib"
  t.libs << "test"
  t.test_files = FileList["test/*_test.rb"]
end
