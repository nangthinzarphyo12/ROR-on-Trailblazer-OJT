class PostService
    class << self
        def getAllPosts
            @posts = PostRepository.getAllPosts
        end

        def getPostByID(id)
            @post = PostRepository.getPostByID(id)
        end

        def insertPost(insertParams)
            postCreate = PostRepository.insertPost(insertParams)
        end

        def updatePost(updateParams,post)
            isUpdated = PostRepository.updatePost(updateParams,post)
        end

        def deletePost(id)
            @deleteRecord = PostService.getPostByID(id)
            isDeleted = PostRepository.deletePost(@deleteRecord)
        end

        def searchPost(searchKey)
            issearched = PostRepository.searchPost(searchKey)
        end

    end
end