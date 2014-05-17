require 'lotus/model'
require 'lotus/model/adapters/sql_adapter'
require 'pg'

require 'lotus/view'

require 'lotus/controller'

require 'lotus/router'

class Post
  include Lotus::Entity

  self.attributes = :title, :body
end

class PostRepository
  include Lotus::Repository
end

mapper = Lotus::Model::Mapper.new do
  collection :posts do
    entity Post
    attribute :id, Integer
    attribute :title, String
    attribute :body, String
  end
end

adapter = Lotus::Model::Adapters::SqlAdapter.new(mapper, 'postgres://localhost/lotus_blog')

PostRepository.adapter = adapter
mapper.load!

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
    posts = PostRepository.all
    self.body = Posts::Index.render(format: :html, posts: posts)
  end
end

app = Lotus::Router.new do
  get '/', to: Index.new
end

run app
