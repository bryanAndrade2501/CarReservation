class RoomsController < ApplicationController
  before_action :protect_pages

  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @users = User.all_except(Current.user)
  end

  def show
    @single_room = Room.find_by(id: params[:id])
    
    @room = Room.new
    @rooms = Room.public_rooms

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = User.all_except(Current.user)

    render 'index'
  end

  def create
    @room = Room.create(name: params[:room][:name])
  end

end
