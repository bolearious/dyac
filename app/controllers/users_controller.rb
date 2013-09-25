class UsersController < ApplicationController
	respond_to :json, :xml
	
	# GET /users
	def index
		@users = User.all
		respond_with @users
	end
	
	# POST /users
	def create
		@user = User.create(params[:user])
		respond_with @user
	end
	
	# GET /users/new
	def new
		@user = User.new
		respond_with @user
	end
	
	# GET /users/:id/edit
	def edit
		show # unless you are dressing up show, they are the same thing
	end
	
	# GET /users/:id
	def show
		@user = User.find(params[:id])
		respond_with @user
	end
	
	# PUT /users/:id
	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		respond_with @user
	end
	
	# DELETE /users/:id
	# TODO: add an active flag to users. deleting data is bad.
	def destroy 
		respond_with( {:error => 'This feature is not yet supported' }, :status => 404 )
	end
end
