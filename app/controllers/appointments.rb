require 'sinatra'

get '/users/:id/appointments/new' do
  @rooms = Room.all
  @groups = User.find(params[:id]).groups
  erb :"/appointments/new"
end

post '/users/:id/appointments/new' do

   #ZM: No need to do a lookup on grup and room here... just use the ids
  #
  #Appointment.new(group_id: params[:group], room_id: params[:room], etc...)

  new_appt = Appointment.new({group: Group.find_by(name: params[:group]),
              room: Room.find_by(name: params[:room]),
              start_datetime: DateTime.parse("#{params[:date]} #{params[:start_datetime]}"),
              end_datetime: DateTime.parse("#{params[:date]} #{params[:end_datetime]}")})
  
  if new_appt.save
    redirect "/users/#{params[:id]}"
  else
    redirect "/users/#{params[:id]}/appointments/new"
  end
end

get '/users/:id/appointments/:appt_id/edit' do
  @rooms = Room.all
  @groups = User.find(params[:id]).groups
  @appt = Appointment.find(params[:appt_id])

  #ZM Do not leave puts line in final code
  #Also you can use @appt.id here now
  puts "Paramas of Appt ID: #{params[:appt_id]}"
  erb :"/appointments/edit"
end

put '/users/:id/appointments/:appt_id/edit' do
  cur_appt = Appointment.find(params[:appt_id])
  cur_appt.update_attributes({group: Group.find_by(name: params[:group]),
              room: Room.find_by(name: params[:room]),
              start_datetime: DateTime.parse("#{params[:date]} #{params[:start_datetime]}"),
              end_datetime: DateTime.parse("#{params[:date]} #{params[:end_datetime]}")})
  if cur_appt.save
    redirect "/users/#{params[:id]}"
  else
    redirect "/users/#{params[:id]}/appointments/#{params[:appt_id]}/edit"
  end
end

# Use POST route because Sinatra does not recognize DELETE route
# MA found a requirement for using _method that involved Rack:: something or other
# or defining it in the class that inherits from Sinatra::Base
delete '/users/:id/appointments/:appt_id/delete' do |id, appt_id|
  #ZM Tisk Tisk on the p 
  p params
  @cur_appt = Appointment.find(params[:appt_id])
  @cur_appt.destroy
  redirect "/users/#{params[:id]}"
end
