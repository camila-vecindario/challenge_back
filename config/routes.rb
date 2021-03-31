Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: :registrations,
  }
  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'auth#login'
      post '/users', to: 'auth#create'
      get '/users', to: 'users#index'
      get '/users/:userId', to: 'users#find'
      get '/users/:userId/projects', to: 'users#find_projects'
      post '/projects', to: 'projects#create'
      patch '/projects/:projectId', to: 'projects#update'
      get '/projects', to: 'projects#list'
      get '/projects/search', to: 'projects#search'
      get '/projects/:projectId', to: 'projects#find'
      post '/projects/members', to: 'project_accesses#create'
      get '/projects/:projectId/members', to: 'project_accesses#project_members'
      post '/projects/:projectId/leads', to: 'project_leads#create'
      get '/projects/:projectId/leads', to: 'project_leads#list'
    end
  end
  get '/*a', to: 'application#not_found'

end
