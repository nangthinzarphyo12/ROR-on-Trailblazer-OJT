module User::Operation
    class Search < Trailblazer::Operation
        step :search_user_list

        def search_user_list(options,**)
            searchKey = options[:params][:searchInfo]
            options['users'] = User.where("lower (users.name) LIKE :value OR lower (users.email) LIKE :value OR lower (users.phone) LIKE :value ", value: "%#{searchKey}%" ) 
        end
    end
end