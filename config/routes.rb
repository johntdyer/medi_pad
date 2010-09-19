MediPad::Application.routes.draw do

 
    match "login", :to =>"doctor_sessions#new", :as => 'login'
    match "logout", :to =>"doctor_sessions#destroy", :as => 'logout'

    resources :doctor_sessions
    resources :password_resets, :only => [ :new, :create, :edit, :update ]
    resources :procedures

   # resources :charges, :collection => { :add => :put }
    
    resources :charges do
      collection do
        put :add
      end
    end
    
    resources :doctors

    resources :admin

    resources :home, :only=>[:index]
    resources :reports
    resources :patients

    #    match 'patients/search', :to => 'patients#search'


    match 'doctors/update_results.:format', :to => 'doctors#update_results',:via => :post

    #  match 'patients/search/:facility' => 'patients#search', :as=>'facility_search'

    match 'patients/search' => 'patients#index', :as=>'facility_search'

    #  match 'patients' => 'patients#search', :constraints => { :search }
    #  match "patients:search", :to => "patients#search"

    match '/patients' => 'patients#search', :as=>'facility_search'
    
    
    
      #http://localhost:3000/charges/search/name/john
    match 'reports/search/name(/:name)' => 'reports#search', :as=>'reports_name_search'

      #( week,day,month)
    match 'reports/search/last(/:time)' => 'reports#search', :as=>'reports_date_search'
    
    
    
    
    match '/:controller(/:action(/:id))'
    


    root :to=>"home#index"
	 
end
