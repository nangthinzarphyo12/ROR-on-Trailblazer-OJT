module Post::Operation
    class Search < Trailblazer::Operation
        step :search_post_list
        def search_post_list(options,**)
            searchKey = options[:params][:searchInfo]
            options['posts'] = Post.joins(:user).where("lower (posts.title) LIKE :value OR lower (posts.description) LIKE :value OR lower (users.name) LIKE :value", value: "%#{searchKey}%" ).order("posts.updated_at DESC") 
        end
    end
end