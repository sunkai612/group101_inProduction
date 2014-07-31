class GroupsController < ApplicationController

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
	end

	def new
		@group = Group.new
	end

	def edit
		@group = Group.find(params[:id])
	end

	def create
		@group = Group.new(group_params)

		if @group.save
			redirect_to groups_path, :notice => "New discussion has been published"
		else
			render :new
		end
	end

	def update
		@group = Group.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, :notice => "Discussion has been updated sucessfully"
		else
			render :edit
		end
	end

	def destroy
		@group = Group.find(params[:id])

		@group.destroy
		redirect_to groups_path, :alert => "Discussion has been removed sucessfully"
	end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end

end
