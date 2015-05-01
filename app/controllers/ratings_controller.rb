class RatingsController < ApplicationController
	def index
		@ratings = Rating.all
	end

	def new
		@rating = Rating.new
	end

	def create
		@rating = Rating.create(rating_params)
	end

	def update
		offer = Offer.find(params[:id])
		@rating = Rating.find_by(offer_id: offer.id, user_id: offer.user1_id+ offer.user2_id- @current_user.id)
		respond_to do |format|
      		if @rating.update(rating_params)
		        format.html { redirect_to Offer.find(params[:rating][:offer_id]), notice: 'Rating was successfully updated.' }
		        format.json { head :no_content }
      		else
		        # format.html { render action: 'edit'}
		        format.json { render json: @rating.errors, status: :unprocessable_entity }
     		 end
    	end
  	end

  	def rating_params
  		params.require(:rating).permit(:id, :user_id, :offer_id, :score)
  	end
end
