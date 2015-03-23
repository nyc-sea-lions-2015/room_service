#ZM: No need to require these here, they are included in the evn.rb file
require 'sinatra'
require 'shotgun'

# get '/groups' do
# @groups = Group.all

# erb :'groups/index'
# end


#ZM: Be careful of white spacing
get '/users/:id/groups/new' do
  #@user = User.find_by(id: params[:id])
  @list = User.all

  erb :"groups/new"
end

get '/users/:id/groups/:group_id/edit' do

  #@user = User.find_by(id: params[:id])
  @list = User.all
  @group = Group.find_by(id: params[:group_id])
#  @group_members = @group.users.pluck(:id)

  erb :"groups/edit"
end

post '/users/:id/groups/new' do
  # hacky thing...params[:id] disappears after group?
  user_id = params[:id]
  #if the group saves, this redirects to the appointment group
  group = Group.new(name: params[:name])
  
  
  #ZM: You should probably not be operation over the params array like this.
  list_user_id = params.keep_if { |k,v| v == 'on' }
  group.user = User.find_by(id: user_id)

  #ZM This will be a performance issue if you have lots of users
  #Just use the users_id again 
  group.users = list_user_id.keys.map! { |id| User.find_by(id: id) }
  group.save

  redirect "/users/#{user_id}/appointments/new"

end

put '/users/:id/groups/:group_id/edit' do
  user_id = params[:id]
  group = Group.find_by(id: params[:group_id])
  list_user_id = params.keep_if { |k,v| v == 'on' }
  group.user = User.find_by(id: user_id)
  group.users = list_user_id.keys.map! { |id| User.find_by(id: id) }
  group.save

  redirect "/users/#{user_id}/appointments/new"

end
