class PostRepository
    class << self
        def getAllPosts
            @posts = Post.all.order('updated_at DESC')
        end

        def getPostByID(id)
            @post = Post.find(id)
        end

        def insertPost(insertData)
            postCreate = insertData.save
        end

        def updatePost(updateData,updateRecord)
            postUpdate = updateRecord.update(updateData)
        end

        def deletePost(deleteRecord)
            postDelete = deleteRecord.delete
        end

        def searchPost(searchKey)
            postSearch = Post.joins(:user).where('users.id' == 'posts.created_by').where('description LIKE :search OR title LIKE :search OR name LIKE :search', search: "%#{searchKey}%").order('updated_at DESC')
        end
    end
end