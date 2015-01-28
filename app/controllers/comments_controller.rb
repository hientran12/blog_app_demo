class CommentsController < ApplicationController
	#before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy


	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = "Comment created!"
		else
			flash[:danger] = "Comment failed!"
		end
		redirect_to :back
	end

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted!"
		redirect_to request.referrer || current_entry
	end

	private

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to current_entry if @comment.nil?
	end

	def comment_params
		params.require(:comment).permit(:content,:user_id,:entry_id,)
	end
	def current_entry
		Entry.find(@comment.entry_id) unless @comment.nil?
	end

end
