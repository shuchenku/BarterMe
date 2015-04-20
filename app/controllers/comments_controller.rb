class CommentsController < ApplicationController


  def index
    @comments = Offer.where(id: params["offer_id"]).first.comments
  end

  def show
    @comment = Comment.where(id: params["id"], offer_id: params["offer_id"])
  end

  def new
    @offer = Offer.find(params[:offer_id])
    @comment = @offer.comments.new
  end

  def create
    @offer = Offer.find(params.require(:offer_id))
    clean_params = params.require(:comment).permit(:from, :message)
    @comment = @offer.comments.new(clean_params)
    if @comment.save
        # push_count(@offer.id, @offer.comments.count)
        redirect_to @offer, notice: 'comment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
  end

  private

  # def push_count(offer_id, count)
  #   Pusher.trigger('formdemo_channel', 'comment_event', {offer_id: offer_id, count: count})
  # end
end