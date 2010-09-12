MediPad::Application.routes.draw do

 
    match "login", :to =>"doctor_sessions#new", :as => 'login'
    match "logout", :to =>"doctor_sessions#destroy", :as => 'logout'



    resources :doctor_sessions
    resources :password_resets, :only => [ :new, :create, :edit, :update ]
    resources :procedures
    resources :charges, :collection => { :add => :put }
    resources :doctors

    resources :admin

    resources :home
    resources :reports
    resources :patients

#    match 'patients/search', :to => 'patients#search'
    
    
    
    match 'doctors/update_results.:format', :to => 'doctors#update_results',:via => :post

  #  match 'patients/search/:facility' => 'patients#search', :as=>'facility_search'

    match 'patients/search' => 'patients#index', :as=>'facility_search'



#  match 'patients' => 'patients#search', :constraints => { :search }
 


#    match "patients:search", :to => "patients#search"

  match '/patients' => 'patients#search', :as=>'facility_search'


  
    
    match '/:controller(/:action(/:id))'
    


    root :to=>"home#index"
	 
end
