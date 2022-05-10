class UserController < ApplicationController
    before_action :authenticate_user!

    def availables
        @users = User.all
    end

    def friends
        @users = current_user.friends
    end

    def show
        @user = User.find(params[:id])
    end

    def requestings
        @users = current_user.requestings
    end

    def be_requesteds
        @users = current_user.be_requesteds
    end

    def add_friend
        current_user.add_friend(params[:id])
        redirect_to requestings_path
    end

    def accept_friend
        current_user.accept_friend(params[:id])
        redirect_to friends_path
    end
end
