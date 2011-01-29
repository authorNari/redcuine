require "test_helper"

class IssueTest < Test::Unit::TestCase
  def setup
    super
    Redcuine::CONFIG["site"] = "http://localhost:3000/"
    Redcuine::CONFIG["user"] = "user"
    Redcuine::CONFIG["password"] = "password"
    Redcuine::CONFIG["rest_type"] = :get
    Redcuine::Issue.class_variable_set("@@default_param", {})
  end

  def test_run
    stub(Redcuine::Resource::Issue).find{[]}
    assert_equal true, Redcuine::Issue.run
    assert_equal({},
                 Redcuine::Issue.class_variable_get("@@default_param"))
  end

  def test_run_with_api_key
    stub(Redcuine::Resource::Issue).find{[]}
    Redcuine::CONFIG["enable_api_key"] = true
    assert_equal true, Redcuine::Issue.run
    assert_equal({:key => Redcuine::CONFIG["api_key"]},
                 Redcuine::Issue.class_variable_get("@@default_param"))
  end

  def test_get
    @opts = nil
    stub(Redcuine::Resource::Issue).find{|_, o| @opts = o; []}
    Redcuine::CONFIG["rest_type"] = :get
    Redcuine::CONFIG["project_id"] = "1"
    Redcuine::CONFIG["tracker_id"] = "2"
    Redcuine::CONFIG["assigned_to"] = "3"
    Redcuine::CONFIG["status_id"] = "4"
    assert_equal true, Redcuine::Issue.run
    assert_equal({:params => {:project_id => "1",
                   :tracker_id => "2",
                   :assigned_to => "3",
                     :status_id => "4"}},
                 @opts)
  end

  def test_get_with_id
    @id = nil
    stub(Redcuine::Resource::Issue).find do |id|
      @id = id
      OpenStruct.new
    end
    Redcuine::CONFIG["rest_type"] = :get
    Redcuine::CONFIG["id"] = "1"
    assert_equal true, Redcuine::Issue.run
    assert_equal("1", @id)
  end

  def test_post
    @opt = nil
    stub(Redcuine::Resource::Issue).new do |opt|
      @opt = opt
      o = Object.new
      o.instance_eval("def save; true; end")
      o
    end
    Redcuine::CONFIG["rest_type"] = :post
    Redcuine::CONFIG["project_id"] = "1"
    keys = [:subject, :description, :tracker_id, :status_id,
            :category_id, :assigned_to, :priority, :fixed_version,
            :start_date, :due_date, :estimate_date, :done_ratio]
    keys.each do |k|
      Redcuine::CONFIG[k.to_s] = true
    end
    assert_equal true, Redcuine::Issue.run
    assert_equal([], keys - @opt.keys)
  end

  def test_post_fail
    Redcuine::CONFIG["rest_type"] = :post
    assert_equal false, Redcuine::Issue.run
  end

  def test_put
    stub(Redcuine::Resource::Issue).find do |id|
      @id = id
      @obj = Object.new
      @obj.instance_eval("def save; true; end")
      @obj.instance_eval("def load(args); @opt = args; end")
      @obj
    end
    Redcuine::CONFIG["rest_type"] = :put
    Redcuine::CONFIG["id"] = "1"
    keys = [:subject, :description, :tracker_id, :status_id,
            :category_id, :assigned_to, :priority, :fixed_version,
            :start_date, :due_date, :estimate_date, :done_ratio]
    keys.each do |k|
      Redcuine::CONFIG[k.to_s] = true
    end
    assert_equal true, Redcuine::Issue.run
    assert_equal("1", @id)
    assert_equal([], keys - @obj.instance_variable_get("@opt").keys)
  end

  def test_put_fail
    Redcuine::CONFIG["rest_type"] = :put
    assert_equal false, Redcuine::Issue.run
  end
end
