Rails.application.routes.draw do
  root 'youtube_search#show' 
  get 'youtube_search/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
