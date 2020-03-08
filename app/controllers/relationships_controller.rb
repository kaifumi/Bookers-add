class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create

    @user=User.find(params[:followed_id])
    current_user.follow(@user)
    # formatがhtmlかjsによって出し方が異なる
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
    # redirect_to user
  end

  def destroy
    # Relationshipテーブルから受け取ったidに一致するレコードを探して、followedに対応するものを抽出
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
    # redirect_to user
  end
end
