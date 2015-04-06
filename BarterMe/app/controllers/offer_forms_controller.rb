class OfferFormsController < ApplicationController

	respond_to :html

	def new
		@offer_form = OfferForm.new
	end

	def create
		@offer_form = OfferForm.new(params[:offer_form])
		respond_to do |format|
			if @offer_form.valid?
				format.html { redirect_to new_offer_path(@offer_form.transform), notice: 'Offer valid.' }
				format.json { head :no_content }
			else
				format.html { redirect_to new_offer_form_path, notice: @offer_form.errors.messages.values.join(', ') }
				format.json { render json: @offer_form.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def offer_form_params
		params.require(:offer_form).permit(:item1_ids, :item2_ids)
	end
end
