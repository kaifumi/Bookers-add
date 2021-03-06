class BooksController < ApplicationController
	# before_action :user_check,only:[:edit]

  def show
	  @book = Book.find(params[:id])
	  @user=current_user
	  @book_new=Book.new
	  @post_comments=PostComment.where(book_id:params[:id])
	  @post_comment=PostComment.new
  end

  def index
		@user=current_user
		@book=Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
	  @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
	  @book.user_id=current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
		else
			flash.now[:alert] = "error 投稿失敗です"
			@user=current_user
			@book=Book.new
			@books = Book.all
			render 'index'
  	end
  end

  def edit
		@book = Book.find(params[:id])
		if @book.user_id==current_user.id
			render :edit
		else
			redirect_to books_path
		end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
		else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
			flash.now[:alert] = "error 投稿失敗です"
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title,:body)
  end

  # def user_check
	# 	@book=Book.find(params[:id])
	# 	if @book.user_id==current_user.id
	# 	else
	# 		@book=Book.new
  # 		@books = Book.all
	# 		redirect_to books_path
	# 	end
	# end

end
