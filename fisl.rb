#fisl.rb
require 'rubygems'
require 'sinatra'
require 'dm-core'
require  'dm-migrations'
#require 'dm-serializer'
require 'dm-validations'
require 'models.rb'
#require 'json'


before do
  # bind params
  new_params = {}
  params.each_pair do |full_key, value|
    this_param = new_params
    split_keys = full_key.split(/\]\[|\]|\[/)
    split_keys.each_index do |index|
      break if split_keys.length == index + 1
      this_param[split_keys[index]] ||= {}
      this_param = this_param[split_keys[index]]
   end
   this_param[split_keys.last] = value
  end
  request.params.replace new_params
end


# Pagina Inicial
get '/' do
  @apps = FislApp.all
  erb :index
end


get '/app/new' do
  @app = FislApp.new
  erb :form
end


post '/app/new' do
  FislApp.create(params[:app])
  redirect '/'
end


get '/app/:id' do
  @app = FislApp.get(params[:id])
  if @app
    @message = {:type=>'info',:text=>'Utilize sua Senha para salvar as alterações!'}
    erb :form
  else
    redirect 404
  end
end


post '/app/:id' do
  @old = FislApp.get(params[:id])
  @app = FislApp.new(params[:app])
  if @old.password == @app.password
    @old.update(params[:app])
    redirect '/'
  else
    @message = {:type=>'error',:text=>'Oops! Senha inválida!'}
    erb :form
  end
end

delete ':id' do

end


helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end


error 404 do
  erb '<h1>Ooops! Viajou magrão! Essa página não existe...</h1>'
end


# Saas Stylesheets
get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
#  sass :stylesheet
end
