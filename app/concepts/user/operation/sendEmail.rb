module User::Operation
    class SendEmail < Trailblazer::Operation
        step :search_user_by_email

        def search_user_by_email(options,**)
            searchKey = options[:params][:email]
            options['user'] = User.find_by(email: searchKey)
        end
    end
end