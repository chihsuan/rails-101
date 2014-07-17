class PostsController < ApplicationController
	before_action :login_required, :only => [:new, :create, :edit,:update,:destroy]
	before_action :member_required, :only => [:new, :create ]


	def new
		@group = Group.find(params[:group_id])
		@post = @group.posts.build
	end

	def create
		@group = Group.find(params[:group_id])
		@post =@group.posts.new(post_params)

		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end


	def update
		@post = current_user.posts.find(params[:id])


		if @post.update(post_params)
			redirect_to group_path(@group)
		else
			render :edit
		end
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@posts.destroy
		redirect_to group_path(@group)
	end

	def member_required
		@group = Group.find(params[:group_id])
		if !current_user.is_member_of?(@group)
			flash[:warning] = " You are not member of this group!"
			redirect_to group_path(@group)
		end
	end

	private
	
	def post_params
		params.require(:post).permit(:content)
	end
end
