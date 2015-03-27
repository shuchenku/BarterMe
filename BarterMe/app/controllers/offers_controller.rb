class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    user = User.find_by(id: session[:user_id])
    @offers = Offer.mine? user 
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to '/', notice: 'Offer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { redirect_to '/', notice: 'Offer invalid.' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   item2_ids = offer_params[:item2_id].split(",")
  #   success_flag = true

  #   ActiveRecord::Base.transaction do
  #     item2_ids.each do |id| 
  #       cur_param = offer_params
  #       cur_param[:item2_id] = id
  #       @offer = Offer.new(cur_param)       
  #       success_flag = false unless @offer.save
  #     end
  #   end

  #   respond_to do |format|
  #     if success_flag
  #       format.html { redirect_to "/", notice: 'Offer was successfully created.' }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @offer.errors, status: :unprocessable_entity }
  #     end
  #   end

  # end



  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      ids = params[:item2_ids] || ['none selected']
      params[:offer][:item2_id] = ids.join(",")
      params.require(:offer).permit(:user1_id, :user2_id, :item1_id, :item2_id, :accepted)
    end
  end
