module User::Operation
    class UpdatePassword < Trailblazer::Operation
        class Present < Trailblazer::Operation
            step Model(User, :find_by)
            step Contract::Build(constant: User::Contract::UpdatePassword)
        end
        
        step Nested(Present)
        step Contract::Validate(key: :user)
        step Contract::Persist()
    end
end