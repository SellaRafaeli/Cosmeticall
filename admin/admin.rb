MANAGEABLE_COLLECTIONS = [:users,:contact_supplier,:contact_us,:errors, :sms_messages, :quotes]
#MANAGEABLE_COLLECTIONS+=[:requests]
MANAGEABLE_COLLECTIONS.map! {|n| $mongo.collection(n) }

get '/admin/quotes_list' do
  full_page_card(:"quotes_list")  
end

get '/admin/sms_list' do
    full_page_card(:"sms_list")  
end

get '/admin/set_lang' do
    $redis.set("site_lang", params[:lang])
    redirect  '/admin/dashboard'
end

SECRET_VALUE =  "cookiemonster"
get '/admin/dashboard' do
    full_page_card(:"admin_dashboard")  
end

get '/admin/add_fake_users' do
  add_fake_users
  {add: "added faker users"}
end

get '/admin/remove_fake_users' do
  remove_fake_users
  {msg: "removed faker users"}
end

get "/admin_set_cookie" do 
  if params[:monster] == "cookie"
    cookies[:admin_cookie] = 'cookiemonster'
    redirect to('/')
  end
end

def is_admin(user = cu)
  false
rescue 
  false
end

get '/admin/login' do
  session[:user_id] = params['_id']
  user = $users.get(_id:params['_id'])
  user_name = user["name"]
  flash.message = t('you_are_logged_in_as') + user_name
  redirect '/' 
end

get '/admin' do
  #to_page(:"admin/dashboard")
  redirect '/admin/manage/users'
end

get '/admin/api_spec' do
  erb :"admin/api_spec", default_layout
end

get "/admin/manage/:coll" do 
  erb :"admin/items", default_layout
end 



before '/admin*' do
  protected!
end

def verify_admin_val(collection, field, val)
  # if you want to verify admin value, you can do it by collection
  # and/or field 
  # mock-code
  # if collection == 'something'
  #   if field == 'something'
  #     halt_bad_input(msg: 'Bad input')

  if field == 'latitude' || field == 'longitude'
      val = val.to_f
  end
  val
end

post '/admin/create_item' do
  require_fields(['coll'])
  coll = $mongo.collection(params[:coll])
  fields = mongo_coll_keys(coll)
  data   = params.just(fields)
  coll.add(data)
  redirect back
end

post '/admin/update_item' do
  require_fields(['id','field','coll'])
  coll, field, val = params[:coll], params[:field], params[:val]
  verified_val = verify_admin_val(coll, field, val)
  res = $mongo.collection(params[:coll]).update_id(params[:id],{field => verified_val})
  {msg: "ok", new_item: res}
end

post '/admin/delete_item' do
  require_fields(['id','coll'])
  $mongo.collection(params[:coll]).delete_one({_id: params[:id]})
  {msg: "ok"}
end


