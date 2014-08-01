class GroupsController < ApplicationController

	before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def new
		@group = Group.new
	end

	def edit
		@group = current_user.groups.find(params[:id])
	end

	def create
		@group = current_user.groups.new(group_params)

		if @group.save
			current_user.join!(@group)
			redirect_to groups_path, :notice => "New group has been published"
		else
			render :new
		end
	end

	def update
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, :notice => "Group description has been updated sucessfully"
		else
			render :edit
		end
	end

	def destroy
		@group = current_user.groups.find(params[:id])

		@group.destroy
		redirect_to groups_path, :alert => "Group has been removed sucessfully"
	end

	def join
		@group = Group.find(params[:id])

		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "Join the group sucessfully"
		else
			flash[:warning] = "You are already a group member"
		end

		redirect_to group_path(@group)
	end

	def quit
		@group = Group.find(params[:id])

		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:notice] = "Quit the group sucessfully"
		else
			flash[:warning] = "You are not a group member"
		end

		redirect_to group_path(@group)
	end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end

end
