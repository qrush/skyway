require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "summary is extracted" do
    article = Article.new(body: "one\n\ntwo")
    assert_equal "one", article.summary
  end
end
