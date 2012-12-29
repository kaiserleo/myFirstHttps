require 'sinatra'

set :port, 80

get '/*' do
  redirect "https://#{request.host}"
end

post '/*' do
  redirect "https://#{request.host}"
end
