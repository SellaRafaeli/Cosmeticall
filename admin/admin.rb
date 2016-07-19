MANAGEABLE_COLLECTIONS = [:users,:user_messages,:contact_us]
#MANAGEABLE_COLLECTIONS+=[:requests]
MANAGEABLE_COLLECTIONS.map! {|n| $mongo.collection(n) }

get '/admin/login' do
  session[:user_id] = params['_id']
  user = $users.get(_id:params['_id'])
  user_name = user["name"]
  flash.message = "You are now logged in as #{user_name}"
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

def is_admin(user = cu)
  return true 
  # phone = user['phone'] 
  # return true if phone == '9720549135125' 
  # return false
rescue 
  false
end

before '/admin*' do
  halt(404) unless is_admin
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