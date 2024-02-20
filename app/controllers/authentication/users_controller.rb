class Authentication::UsersController < ApplicationController

    skip_before_action :protect_pages
    

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path, notice: t('.created')
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find(params[:id])
        if Current.user.admin == true
            @users = User.all_except(Current.user)
        else
            @users = User.all_except(Current.user).where(admin: true)
        end

        @room = Room.new
        @rooms = Room.public_rooms
        @room_name = get_name(@user, Current.user)

        @single_room = Room.find_by(name: @room_name) || Room.create_private_room([@user, Current.user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(created_at: :asc)

        render 'rooms/index'

    end


    private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password)
    end

    def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
    end

end