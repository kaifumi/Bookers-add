class UsersController < ApplicationController
	before_action :baria_user, only: [:update]
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]


  def show
  	@user = User.find(params[:id])
  	@books = @user.books
		@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
		@user=current_user
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
	  @user = User.find(params[:id])
	  if @user.id==current_user.id
		render "edit"
	 else
		redirect_to user_path(current_user)
	 end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(current_user), notice: "successfully updated user!"
	else
		flash.now[:alert] = "error 編集失敗です"
		@books = @user.books
  		@book = Book.new
  		render "show"
  	end
  end

	def following
		@title = "フォロー一覧"
    @user  = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		@book = Book.new
    render 'show_follow'
  end

	def followers
		@title = "フォロワー一覧"
    @user  = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		@book = Book.new
    render 'show_follow'
  end

		
	# メール送信機能
	def create
		if @user.save
			NotificationMailer.send_confirm_to_user(@user).deliver
			redirect_to @user
		else
			render 'new'
		end
	end

	def self.send_regular_mail
		@user=User.find(1)
		NotificationMailer.send_regular_to_user(@user).deliver
	end

  private
  def user_params
		params.require(:user).permit(:name, :introduction, :profile_image,
			:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   	def baria_user
  		unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  		end
	 	end

end
