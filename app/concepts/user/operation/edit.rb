module User::Operation
    class Edit < Trailblazer::Operation
        step Model(User, :find_by)
    end
end