require 'sinatra'

get '/' do

  @rooms = Room.all

 # rooms.each
 #   appointments.each
  #     group.name | st |end 

  #DO NOT do AR Queries in your views -->
  # <!--{room_name: 'objc', appointments[ {name: , start_tm: , end_tm}, {} {}, {} ] -->
  erb :index
end

