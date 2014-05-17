require 'lotus/controller'

class Index
  include Lotus::Action

  def call(params)
    self.body = 'all the blog posts!'
  end
end

run Index.new
