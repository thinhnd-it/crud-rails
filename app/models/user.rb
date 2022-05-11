class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  REQUESTING = 'requesting'
  BE_REQUESTED = 'be_requested'
  ACCEPTED = 'accepted'

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :notifications, as: :recipient

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: {status: 'accepted'})}, through: :friendships

  has_many :requestings, 
    -> { where(friendships: {status: 'requesting'})}, 
    :class_name => 'User', 
    through: :friendships,
    foreign_key: "friend_id",
    source: :friend

  has_many :be_requesteds, 
    -> { where(friendships: {status: 'be_requested'})}, 
    :class_name => 'User', 
    through: :friendships, 
    foreign_key: "user_id",
    source: :friend

  def unfriend(id)
    another_user = User.find(id)
    self.friends.delete(another_user)
    another_user.friends.delete(self)
  end

  def unrequest(id)
    another_user = User.find(id)
    requestings.delete(another_user)
    Rails.logger.info(another_user.be_requesteds)
    another_user.be_requesteds.delete(self)
  end

  def unaccept(id)
    another_user = User.find(id)
    self.be_requesteds.delete(another_user)
    another_user.requestings.delete(self)
  end

  def unacceptAll
    FriendShip.where('user_id = ? OR friend_id = ? AND status != ?', current_user.id, current_user.id, 'accepted').delete_all
  end

  def is_show?(another_user)
    friends.include?(another_user) || requestings.include?(another_user) || be_requesteds.include?(another_user)
  end

  def add_friend(id)
    another_user = User.find(id)
    friendships.create(friend: another_user, status: REQUESTING)
    another_user.friendships.create(friend: self, status: BE_REQUESTED)
  end

  def accept_friend(id)
    another_user = User.find(id)
    friendships.where(friend_id: id).update(status: ACCEPTED)
    another_user.friendships.where(friend_id: self.id).update(status: ACCEPTED)
  end
end