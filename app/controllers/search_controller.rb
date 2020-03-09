class SearchController < ApplicationController
  def search
    table = params[:search_table]
    method = params[:search_method]
    word = params[:search_word]
    # byebug
    if table=="1"
      @users=User.search(method,word)
    elsif  table=="2"
      #Viewのformで取得したパラメータをモデルに渡す
      @books = Book.search(method,word)
    else
      flash[:alert]="検索に失敗しました"
      redirect_to request.referer
    end
    @user=current_user
    @book=Book.new
  end
end
