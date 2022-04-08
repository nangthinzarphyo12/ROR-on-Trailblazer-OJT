require 'bcrypt'
module User::Operation
    include BCrypt
    class Create < Trailblazer::Operation
        class Present < Trailblazer::Operation
            step Model(User, :new)
            step Contract::Build(constant: User::Contract::Create)
        end
        step Nested(Present)
        step Contract::Validate(key: :user)
        step :generate_pwd!
        step Contract::Persist()

        def generate_pwd!(options, **)
            # puts(options)
            options[:params][:user][:password] = BCrypt::Password.create(options[:params][:user][:password])
            # model.password_digest = options[:params][:user][:password]
        end

        # def password!(options,**)
        #     @password = options[:params][:users][:password]
        #     puts('---------------pw')
        #     puts(password)
        #     password_hash = Password.create(password)
        #     password= Password.create(password)
        #     puts(password)
        #   end
    end
end