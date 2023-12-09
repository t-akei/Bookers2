class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    # redirect_to request.referer
    # 非同期通信を行う場合は、JavaScriptファイル（.js.erb）を使用して
    # ビューを更新します。redirect_toを消す事で自動的にアクションに対応するjsファイルを探しにいく。
    # 今回はcreate.js.erbファイルを探しにいく
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy
    # redirect_to request.referer
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
