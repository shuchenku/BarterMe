class CategoriesController < ApplicationController
  # before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    # respond_to do |format|
      @category.save
      #   format.html { redirect_to @category, notice: 'Category was successfully created.' }
      #   format.json { render action: 'show', status: :created, location: @category }
      # else
      #   format.html { render action: 'new' }
      #   format.json { render json: @category.errors, status: :unprocessable_entity }
      # end
    # end
  end


  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    # respond_to do |format|
    #   format.html { redirect_to categories_url }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
