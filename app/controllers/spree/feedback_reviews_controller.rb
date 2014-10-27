class Spree::FeedbackReviewsController < ApplicationController
  # Create ReviewHelpful, call by ajax
  def create
    @fa_review = Spree::Review.find(params_helpfuls[:review_id])
    fa_is_helpful = params_helpfuls[:is_helpful]
    
    if fa_is_helpful == "true"
      @fa_review.is_helpful += 1
    else
      @fa_review.non_helpful += 1
    end
    
    if @fa_review.save
      render json: @fa_review
    else
      render json: false
    end
  end
  
  private
    def params_helpfuls
      params.require(:helpfuls).permit(:review_id, :is_helpful)
    end

end