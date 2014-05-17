require 'lotus/controller'
require 'lotus/view'

module Posts
  class Index
    include Lotus::View
  end
end

Lotus::View.root = 'templates'
Lotus::View.load!

class Index
  include Lotus::Action

  def call(params)
    self.body = Posts::Index.render(format: :html)
  end
end

run Index.new
