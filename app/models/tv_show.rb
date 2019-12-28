class TvShow < ApplicationRecord
    has_many :episodes
    

    def get_attributes
        new_hash = remove_ts(self.attributes)
        new_hash['seasons'] ={}
        tv_episodes = get_episodes
        tv_episodes.each{|ep|
            if(!new_hash['seasons'][ep['season']])
                new_hash['seasons'][ep['season']] = [ep]
            else
                new_hash['seasons'][ep['season']] << ep
            end
        }
        new_hash
    end

    def get_episodes
        self.episodes.map{|ep| remove_ts(ep.attributes)}
    end
    
    def remove_ts(hash)
        hash.reject{|key,v| key == "created_at" || key == "updated_at"}
    end

end
