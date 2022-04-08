module SpecTestHelper
    def current_user
      User.where(email:  "nangthinzarphyo12@gmail.com").take
    end
end