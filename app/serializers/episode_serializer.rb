class EpisodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :episode_number, :tv_show_id, :season, :api, :overview
end
