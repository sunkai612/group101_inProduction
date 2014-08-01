module PostsHelper

	def render_post_context(post)
    	truncate(simple_format(post.context), :lenth => 100)
  	end

end
