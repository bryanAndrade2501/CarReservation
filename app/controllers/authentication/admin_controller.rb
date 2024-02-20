class Authentication::AdminController < ApplicationController

    before_action :protect_pages
    before_action :authorize!

    def index
        @users = User.all
    end


end