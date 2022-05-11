class UserController < ApplicationController
    before_action :authenticate_user!

    def availables
        @users = User.all
    end

    def friends
        session[:count_requested] = current_user.be_requesteds.size
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
        ActionCable.server.broadcast("notifications:#{params[:id]}", { count: User.find(params[:id]).be_requesteds.size})
        redirect_to requestings_path
    end

    def accept_friend
        current_user.accept_friend(params[:id])
        ActionCable.server.broadcast("notifications:#{params[:id]}", { count: User.find(params[:id]).be_requesteds.size})
        redirect_to friends_path
    end
end
