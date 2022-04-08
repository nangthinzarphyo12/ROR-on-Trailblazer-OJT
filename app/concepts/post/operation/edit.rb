module Post::Operation
    class Edit < Trailblazer::Operation
        step Model(Post, :find_by)
    end
end