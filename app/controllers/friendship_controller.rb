class FriendshipController < ApplicationController

    def destroy
        current_user.unfriend(params[:id])
        redirect_to friends_path
    end
    
    def destroy_request
        current_user.unrequest(params[:id])
        ActionCable.server.broadcast("notifications:#{params[:id]}", { count: User.find(params[:id]).be_requesteds.size})
        redirect_to friends_path
    end

    def un_accept
        current_user.unaccept(params[:id])
        ActionCable.server.broadcast("notifications:#{current_user.id}", { count: User.find(current_user.id).be_requesteds.size})
        redirect_to friends_path
    end

end
