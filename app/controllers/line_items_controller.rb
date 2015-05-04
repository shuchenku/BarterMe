class LineItemsController < ApplicationController
  # include CurrentCart
  # before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    item = Item.find(params[:item_id])
    @line_item = @cart.add_item(item.id)
    if @line_item == -1
      respond_to do |format|
        format.html {
          redirect_to items_url,
          notice: 'Item already in your watchlist'}
      end
    else
      respond_to do |format|
        if @line_item.save
          if item.user_id == session[:user_id]
            redirect_path = 'offer/new'
          else
            redirect_path = @line_item.cart
          end
          format.html { 
            redirect_to redirect_path,
            notice: 'Item added to your cart.' }
          format.json { render action: 'show', status: :created, location: @line_item }
        else
          format.html { render action: 'new' }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:item_id)
    end
end
