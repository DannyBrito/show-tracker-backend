class TvShow < ApplicationRecord
    has_many :episodes

    def get_attributes
        new_hash = self.attributes.reject{|key,v| key == "created_at" || key == "updated_at"}
        new_hash[:episodes] = get_episodes
        new_hash[:episodes] = new_hash[:episodes].map{|ep| ep.attributes.reject{|key,v| key == "created_at" || key == "updated_at"}}
        new_hash
    end

    def get_episodes
        Episode.where(tv_show_id: self.id)
    end
end
