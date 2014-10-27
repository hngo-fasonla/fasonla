class HelpfulsController < ApplicationController
  def create
    @helpful = ReviewHelpful.new(params_helpfuls)
    if @helpful.save
        respond_to do |format|
          format.xml { render xml: 0}
          format.json { render json: 0 }
        end
      else
        respond_to do |format|
          format.xml { render xml: 1}
          format.json { render json: 1 }
        end
      end
  end
  
  private
    def params_helpfuls
      params.require(:helpfuls).permit(:review_id, :user_id, :is_helpful)
    end
  
end
