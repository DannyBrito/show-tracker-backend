class TvShowSerializer
  include FastJsonapi::ObjectSerializer
  has_many :episodes
  attributes :name, :seasons, :api, :poster_path
end
