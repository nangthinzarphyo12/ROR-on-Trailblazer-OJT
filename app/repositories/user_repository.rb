class UserRepository
    class << self
        def getAllUsers
            @users = User.all
        end

        def getuserByID(id)
            @user = User.find(id)
        end

        def getUserByEmail(email)
            @user = User.find_by(email:email)
            # user = User.find_by(email: params[:session][:email].downcase)
        end

        def insertUser(insertData)
            insertData[:password] = insertData[:password_digest]
            userCreate = insertData.save
        end

        def updateUser(updateData,updateRecord)
            userUpdate = updateRecord.update(updateData)
        end

        def deleteUser(deleteRecord)
            userDelete = deleteRecord.delete
        end
    end
end