class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:index, :show, :search]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_items

 def index
   @similarity_score = Array.new
    if params[:query].present?
      @items = Item.search(params[:query], operator: :or,  page: params[:page], per_page: 10)
      if params[:order].present?
        @items = Item.order(params[:order])
      end
    else
      if params[:order].present?
        @items = Item.order(params[:order]).page(params[:page])
      else
        @items = Item.order("name").page(params[:page])
      end
    end
   if logged_in?
     user2 = User.find_by(id: session[:user_id]) 
     @items.each do |item|
      @similarity_score.push(User.similarity_score(item.user.user_name, user2))
     end
   end
 end
 
 def search
   @items = Item.advsearch params
   respond_to do |format|
     format.js
     format.html
   end
 end

 def my_items
   user = User.find_by(id: session[:user_id])
   @items = Item.mine? user
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
   if @item.user_id != @current_user.id
    redirect_to item_path(@item), notice: "Cannot edit items that aren't yours"
  end
 end
 
 # POST /items
 # POST /items.json
 def create
   
   @item = Item.new(item_params)
   user = User.find_by(id: session[:user_id])
   @item.user_id = user.id
   # category = Category.find_by name: params[:category]
   # @item.category_id = category.id

   
   respond_to do |format|
     if @item.save
       format.html { redirect_to @item, notice: 'Item was successfully created.' }
       format.json { render action: 'show', status: :created, location: @item }
     else
      puts(@item.errors.messages)
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
   begin
     @item.destroy
     flash[:notice] = "Item #{@item.name} deleted"
    end
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
   params.require(:item).permit(:name, :description, :image_url, :user_id, :location, :quantity, :category_id)
 end

 def invalid_items 
   logger.error "Attempt to access another user's items #{params[:id]}" 
   redirect_to "/", notice: 'Invalid cart'
 end
end
