class FriendShipsController < ApplicationController
  def friend_request
    from_user = User.find(params[:from_id])
    to_user   = User.find(params[:to_id])
    if from_user.has_relation?(to_user)
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Already done'
      return
    end

    friend_ship = FriendShip.new(from_user_id: params[:from_id], to_user_id: params[:to_id])
    unless friend_ship.save
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Failed'
      return
    end

    from_user.friendships_from_oneself.push(friend_ship)
    to_user.friendships_to_oneself.push(friend_ship)
    redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Requested'
  end

  def approve
    from_user = User.find(params[:from_id])
    to_user   = User.find(params[:to_id])
    friendship = to_user.pending_friendships_to_oneself.find { |fs| fs.from_user_id.to_s == params[:from_id] }
    if friendship
      friendship.update_attributes(approval: true)
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Success'
    else
      redirect_to controller: :users, action: :show, id: current_user.id, notice: 'Failed'
    end
  end
end
