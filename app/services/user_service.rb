class UserService
    class << self
        def getAllUsers
            @users = UserRepository.getAllUsers
        end

        def getuserByID(id)
            @user = UserRepository.getuserByID(id)
        end

        def getUserByEmail(email)
            @user = UserRepository.getUserByEmail(email)
        end

        def insertUser(insertParams)
            userCreate = UserRepository.insertUser(insertParams)
        end

        def updateUser(updateParams,user)
            print updateParams,@user
            isUpdated = UserRepository.updateUser(updateParams,user)
        end

        def deleteUser(id)
            @deleteRecord = UserRepository.getuserByID(id)
            userDelete = UserRepository.deleteUser(@deleteRecord)
        end

    end
end