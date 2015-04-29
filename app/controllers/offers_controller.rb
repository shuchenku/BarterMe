class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    user = User.find_by(id: session[:user_id])
    proposed_offers = Offer.proposed? user
    received_offers = Offer.received? user
    offers = received_offers.concat(proposed_offers)
    if (params[:pending]=="all" || params[:pending].nil?)
      @offers = offers
    else
      @offers = offers.select {|o| o.pending == (params[:pending]=="true")}
    end
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
        format.html { redirect_to offers_url, notice: 'Offer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer }
        Rating.create(:offer_id => @offer.id, :user_id=>@offer.user1_id, :score => 0)
        Rating.create(:offer_id => @offer.id, :user_id=>@offer.user2_id, :score => 0)

      else
        format.html { redirect_to offers_url, notice: 'Offer invalid.' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def accept
    set_offer
    @offer.update_attributes(:accepted => true, :pending => false)
    redirect_to offers_url
  end

  def reject
    set_offer
    @offer.update_attributes(:accepted => false, :pending => false)
    redirect_to offers_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:user1_id, :user2_id, :item1_id, :item2_id, :accepted, :pending, :rating)
    end
  end
