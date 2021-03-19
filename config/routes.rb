Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: :registrations,
  }

  post '/auth/login', to: 'auth#login'
  get '/users', to: 'users#index'
  get '/users/:userId', to: 'users#find'
  post '/projects', to: 'projects#create'
  patch '/projects/:projectId', to: 'projects#update'
  get '/projects', to: 'projects#list'
  get '/projects/:projectId', to: 'projects#find'
  post '/projects/members', to: 'project_accesses#create'
  get '/projects/:projectId/members', to: 'project_accesses#project_members'
  post '/projects/:projectId/leads', to: 'project_leads#create'
  get '/projects/:projectId/leads', to: 'project_leads#list'
  get '/*a', to: 'application#not_found'

end
