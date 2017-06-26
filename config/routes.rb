Rails.application.routes.draw do

  resources :departments
	resources :students

	root 'departments#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
