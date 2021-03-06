class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all #index action
    erb :index
  end
  
  get '/recipes/new' do #new action  
    erb :new
  end

  post '/recipes' do #create action
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do #show action  
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #edit action
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
 
  patch '/recipes/:id' do #update action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #delete action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
