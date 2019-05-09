require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'data/cookbook'
require_relative 'models/recipe'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'data/recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/create' do
  erb :create
end

get '/layout' do
  erb :layout
end

post '/new_recipe' do
  name = params['r_name']
  description = params['r_description']
  difficulty = params['difficulty']
  prep_time = params['prep_time']
  cookbook.add_recipe(Recipe.new(name, description, prep_time, "0", difficulty))
  redirect "/"
end

post '/delete_recipe' do
  number = params['number'].to_i - 1
  cookbook.remove_recipe(number)
  redirect "/"
end

post '/mark_recipe_done' do
  num = params['mark_num'].to_i - 1
  cookbook.mark_recipe_as_done_at(num)
  redirect "/"
end


get '/recepies/:id' do
  # binding.pry  # <= code will stop here for HTTP request localhost:4567/someone
  id = params[:id].to_i
  @recipe = cookbook.all[id]
  erb :recipe_details
end
