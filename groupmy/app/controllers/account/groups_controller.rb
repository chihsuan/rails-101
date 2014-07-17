class Account::GroupsController < ApplicationController
	before_action :login_required

	def index
		@group = current_user.participated_groups
	end

	
end
