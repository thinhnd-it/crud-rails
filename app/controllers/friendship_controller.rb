class FriendshipController < ApplicationController

    def destroy
        current_user.unfriend(params[:id])
        redirect_to friends_path
    end
    
    def destroy_request
        current_user.unrequest(params[:id])
        redirect_to friends_path
    end

    def un_accept
        current_user.unaccept(params[:id])
        redirect_to friends_path
    end

end
