require "test_helper"

class OptParserTest < Test::Unit::TestCase
  def test_parse_default_opts
    Redcuine::OptParser.issue_parse!(%w(-p))
    assert_equal :post, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(-g))
    assert_equal :get, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(-u))
    assert_equal :put, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(-d))
    assert_equal :delete, Redcuine::CONFIG["rest_type"]

    Redcuine::OptParser.issue_parse!(%w(--post))
    assert_equal :post, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(--get))
    assert_equal :get, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(--put))
    assert_equal :put, Redcuine::CONFIG["rest_type"]
    Redcuine::OptParser.issue_parse!(%w(--delete))
    assert_equal :delete, Redcuine::CONFIG["rest_type"]

    Redcuine::OptParser.issue_parse!(%w(--debug))
    assert_equal true, Redcuine::CONFIG["debug"]
  end

  def test_issue_parse
    opts = %w(id subject description tracker-id status-id
       category-id assigned-to-id priority-id fixed-version
       start-date due-date estimate-date done-ratio site project-id)
    args = opts.map{|k| ["--#{k}", k]}.flatten
    Redcuine::OptParser.issue_parse!(args)
    opts.each do |o|
      assert_equal o, Redcuine::CONFIG[o.gsub("-", "_")]
    end
  end
end
