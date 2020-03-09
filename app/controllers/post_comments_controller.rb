class PostCommentsController < ApplicationController
    def show
        @post_comments=PostComment.where(book_id:params[:book_id])
        @post_comment=PostComment.new
    end

    def create
        @book=Book.find(params[:book_id])
        comment = PostComment.new(post_comment_params)
        comment.book_id=@book.id
        comment.user_id=current_user.id
        comment.save!
        @post_comments=PostComment.where(book_id:params[:book_id])
        @post_comment=PostComment.new
        # redirect_to book_path(params[:book_id])
        
    end

    def destroy
        @book=Book.find(params[:book_id])
        comment=PostComment.find(params[:id])
        comment.destroy
        @post_comments=PostComment.where(book_id:params[:book_id])
        @post_comment=PostComment.new
        # redirect_to book_path(params[:book_id])
    end

    private
    def post_comment_params
        params.require(:post_comment).permit(:id,:comment,:book_id)
    end

end
