class RatingsController < ApplicationController
	def index
		@ratings = Rating.all
	end

	def update
		@rating = Rating.find(params[:id])
		respond_to do |format|
      		if @rating.update_attributes(rating_params)
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
