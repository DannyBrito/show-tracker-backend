class Watchlist < ApplicationRecord
    belongs_to :user
    has_many :watchlist_episodes
    has_many :episodes, through: :watchlist_episodes
    has_many :tv_shows, through: :episodes


    def get_uniq_tv_shows
        self.tv_shows.distinct
    end

    
    
    def get_attributes
        new_hash = remove_ts(self.attributes)
        new_hash['tv_shows'] = {}
        self.watchlist_episodes.order(:tv_show_id).each{ |ep|
        new_format_ep = remove_ts(ep.episode.attributes)
        ts = ep.episode.tv_show
        new_format_ep['tv_show_name'] = ts.name
         new_format_ep['rating'] = ep.rating
         new_format_ep['watched'] = ep.watched
        if(!new_hash['tv_shows'][ep.tv_show_id])
            new_hash['tv_shows'][ep.tv_show_id] = {:seasons=>{new_format_ep['season']=>[new_format_ep]}}
            new_hash['tv_shows'][ep.tv_show_id] = remove_ts(ts.attributes).merge(new_hash['tv_shows'][ep.tv_show_id])
        else
            if(!new_hash['tv_shows'][ep.tv_show_id][:seasons][new_format_ep['season']])
                new_hash['tv_shows'][ep.tv_show_id][:seasons][new_format_ep['season']] = [new_format_ep]
            else
                new_hash['tv_shows'][ep.tv_show_id][:seasons][new_format_ep['season']] << new_format_ep
            end
        end
        new_hash['tv_shows'][ep.tv_show_id][:seasons].each{|k, v| new_hash['tv_shows'][ep.tv_show_id][:seasons][k] = v.sort_by{|e| e['episode_number']}}
        }
        new_hash
    end
    
    
    def remove_ts(hash)
        hash.reject{|key,v| key == "created_at" || key == "updated_at"}
    end
    
    
    def add_tv_show(tv_show_id)
        Episode.where(tv_show_id: tv_show_id).map{|ep| WatchlistEpisode.create(episode: ep, watchlist: self, tv_show_id: ep.tv_show_id)}
    end
    
end

# def get_attributes
#     new_hash = self.attributes.reject{|key,v| key == "created_at" || key == "updated_at"}
#     new_hash['tv_shows'] = {}
#     self.watchlist_episodes.each{ |ep|
#      new_format_ep = ep.episode.attributes.reject{|key,v| key == "created_at" || key == "updated_at"}
#      ts_name = ep.episode.tv_show.name
#      new_format_ep['tv_show_name'] = ts_name
#      new_format_ep['rating'] = ep.rating
#      new_format_ep['watched'] = ep.watched
#     if(!new_hash['tv_shows'][ep.tv_show_id])
#         new_hash['tv_shows'][ep.tv_show_id] = {tv_show_name: ts_name,episodes:[new_format_ep]}
#     else
#         new_hash['tv_shows'][ep.tv_show_id][:episodes] << new_format_ep
#     end
#     }
#     # new_hash[:episodes] = get_episodes
#     # new_hash[:episodes] = new_hash[:episodes].map{|ep| ep.attributes.reject{|key,v| key == "created_at" || key == "updated_at"}}
#     new_hash
# end
