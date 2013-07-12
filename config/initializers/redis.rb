if Rails.env.production?
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new :host => uri.host, :port => uri.port, :password => uri.password  
else
  REDIS = Redis.new :host => 'localhost', :port => 6379  
end

# config resque
Resque.redis = REDIS