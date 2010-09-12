ActionController::Routing::Routes.draw do |map|
  map.login "login",:controller =>"doctor_sessions", :action => "new"
  map.logout "logout",:controller =>"doctor_sessions", :action => "destroy"
  
  map.resources :doctor_sessions
  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]
  map.resources :procedures
  map.resources :charges, :collection => { :add => :put }
  map.resources :doctors
  map.resources :patients
  map.resources :admin
  
  map.resources :home
  map.resources :reports
    
    
  map.connect 'doctors/update_results.:format',:action=>"update_results", :controller=>'doctors',:conditions=>{:method => :post} 
    
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
	map.root :controller => "home"

end
