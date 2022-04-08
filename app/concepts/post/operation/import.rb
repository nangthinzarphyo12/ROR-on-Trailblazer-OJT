module Post::Operation
    class Import < Trailblazer::Operation
        step Contract::Build(constant: Post::Contract::Import)
        step Contract::Validate()
        step :import_csv!
    
        def import_csv!(options, params:, **)
            begin
                CSV.foreach(params[:file].path, headers: true, header_converters: :symbol) do |row|
                    Post.create! row.to_hash.merge(created_by: options['current_user_id'])
                end
                return true
            end
        end
    end
end
  