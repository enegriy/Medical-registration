Intreg::Application.routes.draw do

  #main page
  root :to => 'mainpage#index'


  resource :user_manager, :path=>'user' do
    member do
      get  'license'
      get  'form_restore'
      get  'logout'
      post 'restore_pass'
      post 'login'
    end
  end

  resources :timetables do
    collection do
      get  'add_absence'
      get  'del_absence'
      post 'save_absence'
    end
  end

  scope '/doctor' do
    match 'edit'    => 'doctor_manager#edit',       :as=>'doctor_edit'
    match 'save'    => 'doctor_manager#save',       :as=>'doctor_save'
    match 'show'    => 'doctor_manager#show',       :as=>'doctor_show'
    match 'photo'   => 'doctor_manager#add_photo',  :as=>'doctor_add_photo'
    match 'upload'  => 'doctor_manager#upload',     :as=>'doctor_photo_upload'
  end
  match   ':id'     => 'doctor_manager#profile',    :as=>'doctor_profile'


  scope '/service' do
    match 'get_cities'        => 'service#get_cities'
    match 'get_organizations' => 'service#get_organizations'
    match 'send_visits'       => 'service#send_visits'
    match 'get_license'       => 'service#get_license'
  end


  match '/personal_room/index'   => 'personal_room#index', :via=>:get
  match '/personal_room/history' => 'personal_room#history'
  match '/personal_room/edit'    => 'personal_room#edit_user'
  match '/personal_room/update'  => 'personal_room#update'


  match '/organization/show/:id' => 'organization_manager#show',   :as=>'organization'
  match '/organization/new'      => 'organization_manager#new' 
  match '/organization/create'   => 'organization_manager#create', :via=>:post


  match '/:id/timegrid/' => 'timegrid#index', :as=>'timegrid'


  scope '/tickets' do
    match 'all'                        => 'ticket_manager#list_tickets',     :as=>'list_tickets'
    match 'new/:doctor_id/:visit_date' => 'ticket_manager#new',              :as=>'new_ticket',    :via=>:post
    match 'create'                     => 'ticket_manager#create',           :as=>'create_ticket'
    match 'delete/:id'                 => 'ticket_manager#delete',           :as=>'delete_ticket', :via=>:delete
    match 'show/:id'                   => 'ticket_manager#show',             :as=>'show_ticket'
    match 'delete_collections'         => 'ticket_manager#delete_collections'
  end


  scope '/admin' do
    match 'runsql'  => 'admin#runsql', :as=>'admin_runsql'
    match 'index'   => 'admin#index',  :as=>'admin'
  end


end
