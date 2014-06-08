class FriendShipsController < ApplicationController
  def friend_request
    from_id = params[:from_id]
    to_id   = params[:to_id]
    from_user = User.find(from_id)
    to_user   = User.find(to_id)

    if from_user.has_relation?(to_user)
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Already done'
      return
    end

    friend_ship = FriendShip.new(from_user_id: from_id, to_user_id: to_id)
    if friend_ship.save
      from_user.friendships_from_oneself.push(friend_ship)
      to_user.friendships_to_oneself.push(friend_ship)
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Requested'
    else
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Failed'
    end
  end
end
