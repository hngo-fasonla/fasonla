class RatingsController < ApplicationController
  def index
  end

  # Rating call by ajax, create rating or update rating
  def create
    fa_flag = false
    fa_product_id = params_ratings[:product_id]
    fa_user_id = params_ratings[:user_id]
    fa_ratings = Ratings.all
    # Read Ratings, find rating with {user_id, product_id}
    fa_ratings.each do |fa_rating|
      if fa_rating.user_id == fa_user_id.to_i
        if fa_rating.product_id == fa_product_id.to_i
          fa_flag = true
          # Update rating
          if fa_rating.update(params_ratings)
            render json: true
          else
            render json: false
          end
        end
      end
    end
    # Create rating 
    if(fa_flag == false)
      fa_rating = Ratings.new(params_ratings)
      if fa_rating.save
        render json: true
      else
        render json: false
      end
    end
  end

  private
    def params_ratings
      params.require(:ratings).permit(:product_id, :user_id, :rating)
    end

end
