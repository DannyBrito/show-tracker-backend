class TvShowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :seasons, :api, :poster_path
end
