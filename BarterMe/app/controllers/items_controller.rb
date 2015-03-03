class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:index, :show]
 def index
    if params[:query].present?
      @items = Item.search(params[:query], operator: :or,  page: params[:page], per_page: 10)
    else
      @items = Item.order("name").page(params[:page])
    end
 end

  # GET /items/1
  # GET /items/1.json
  def show
    
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    
    @item = Item.new(item_params)
    user = User.find_by(id: session[:user_id])
    @item.user_id = user.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :image_url, :user_id, :product_key, :type_id, :location, :quantity)
    end
end
