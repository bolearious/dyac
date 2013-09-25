class SpellingsController < ApplicationController
	respond_to :json, :xml
	before_filter :find_user, :except => :show
	rescue_from Exception, :with => :custom_rescue
	
	# GET /users/:user_id/spellings
	# GET /spellings
	def index
		respond_with( {:error => 'You must provide a word.' }, :status => 422 )  # http 422 is unprocessible entity / malformed request
	end
	
	# POST /users/:user_id/spellings
	# POST /spellings
	def create
		unless @custom_word = @user.custom_words.find_by_word(params[:id])
			@custom_word = @user.custom_words.create(word: params[:id], correct: false)
		end
		@custom_word.corrections.create( {replacement: params[:replacement]} )
		
		respond_with @custom_user
	end
	
	# GET /users/:user_id/spellings/new
	# GET /spellings/new
	def new
		respond_with({:correct => true}) # If someone submits 'new', rails will send them here.
	end
	
	# GET /users/:user_id/spellings/:id/edit
	# GET /spellings/:id/edit
	def edit
		unless @custom_word = @user.custom_words.find_by_word(params[:id])
			respond_with( {:error => 'You have not used this word before.' }, :status => 404 )
			return
		end
		respond_with @custom_word  
	end
	
	# GET /users/:user_id/spellings/:id
	# GET /spellings/:id
	def show
		results = Spellchecker.check(params[:id]).first  # Spellchecker gem spec http://rubydoc.info/gems/spellchecker/0.1.5/frames 
		results.delete(:original)   # original word is not part of the api spec
		
		if results[:correct]
			respond_with(results) # They got it right. Nothing more to be done.
			return
		end
		
		unless @user = User.find_by_id(params[:user_id])
			respond_with(results) # No one is logged in. Return the results.
			return
		end
		
		unless @custom_word = @user.custom_words.find_by_word(params[:id])
			respond_with(results) # This is a new word. Return the results.
			return
		end
		
		if @custom_word.correct
			respond_with( {:correct => false} )
		else
			respond_with( {:correct => false, :suggestions => @custom_word.top_corrections.concat( results[:suggestions] ).uniq[0..2] })
		end
	end
	
	# PUT /users/:user_id/spellings/:id
	# PUT /spellings/:id
	def update
		unless @custom_word = @user.custom_words.find_by_word(params[:id])
			respond_with( {:error => 'You have not used this word before.' }, :status => 404 )
			return
		end
		@custom_word.update_attribute( :correct, params[:correct] )
		respond_with @custom_word  
	end
	
	# DELETE /users/:user_id/spellings/:id
	# DELETE /spellings/:id
	def destroy 
		raise 'This feature is not supported'
	end
	
	private
	
	def find_user
		unless @user = User.find_by_id( params[:user_id] ) # find_by_id is safer if the param can be null
			raise 'This feature is for register users only'
		end
	end
	
	def custom_rescue(exception)
		respond_with( {:error => exception.message }, :status => 403 )
	end
end
