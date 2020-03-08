class UsersController < ApplicationController
	before_action :baria_user, only: [:update]
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

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

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   	def baria_user
  		unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  		end
	 	end
	 
		#  application.controller.rbに設置したので不要
		# def logged_in_user
		# 	unless logged_in?
		# 		falsh[:danger]="Please log in."
		# 		redirect_to new_user_session_path
		# 	end
		# end

end
