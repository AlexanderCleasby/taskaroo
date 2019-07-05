class ListSerializer <  ActiveModel::Serializer
    attributes :id, :owner, :title, :completion
    has_many :tasks
    def owner
        {owner_name: self.object.owner.email}
    end 
end