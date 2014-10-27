module ReviewsControllerExtensions
  def new
    super
    rating_work
    check_review_work
    other_purchases_work
  end

  protected
    # Get Rating, when user Rating and has not write Review
    def rating_work
      fa_ratings = Ratings.all
      fa_ratings.each do |fa_rating|
        if fa_rating.user_id == spree_current_user.id
          if fa_rating.product_id == @product.id
            # return for write review using
            @fa_rating = fa_rating.rating
          end
        end
      end
    end
    
    # Check product exist evaluation, with {user.id, product.id}
    def check_review_work
      @fa_check_review = false
      fa_reviews = Spree::Review.search(user_id_eq: spree_current_user.id).result
      fa_reviews.each do |review|
        if review.product_id == @product.id
          # return True if exist evaluation, else return False
          @fa_check_review = true
        end
      end
    end
    
    # Get list products has purchase but not write review
    def other_purchases_work
      @fa_product_purchases = []
      fa_purchase_exist_ids = []
      fa_reduced_ids = []
      
      # Get list orders with {spree_current_user.id}
      fa_orders = Spree::Order.complete.search(user_id_eq: spree_current_user.id).result
      fa_orders.each do |fa_order|
        fa_line_items = Spree::LineItem.search(order_id_eq: fa_order.id).result
        fa_line_items.each do |fa_line_item|
          # Save fa_purchase_exist_ids (list id product exist purchase)
          fa_purchase_exist_ids.push(fa_line_item.variant.product.id)
          # Check product exist review, call check_review_user_id_and_product_id
          check_review_user_id_and_product_id(spree_current_user.id, fa_line_item.variant.product.id)
          # Case product don't exist review in fa_reviews
          if @fa_flag_check_review == false
            # Case product is not current product consider
            if(fa_line_item.variant.product.id != @product.id)
              fa_flag = false
              # Read fa_reduced_ids, set {fa_flag} to reduced product_purchases have repeat product
              fa_reduced_ids.each do |fa_reduced_id|
                if fa_reduced_id == fa_line_item.variant.product.id
                  fa_flag = true
                end
              end
              if fa_flag == false
                # return product_purchases
                @fa_product_purchases.push(fa_line_item.variant.product)
                # Save fa_reduced_ids when {fa_flag == false} to reduced product_purchases have repeat product
                fa_reduced_ids.push(fa_line_item.variant.product.id)
              end
            end
          end
        end
      end
      
      # Check product exist purchases, with {product.id}
      @fa_purchases_exist = 0
      # Read fa_purchase_exist_ids, check product.id exist purchase in fa_purchase_exist_ids
      fa_purchase_exist_ids.each do |fa_purchase_exist_id|
        if fa_purchase_exist_id ==  @product.id
          @fa_purchases_exist = 1
        end
      end
      
    end
    
  private
    def check_review_user_id_and_product_id(user_id, product_id)
      @fa_flag_check_review = false
      fa_reviews = Spree::Review.search(user_id_eq: user_id).result
      fa_reviews.each do |fa_review|
        if fa_review.product_id == product_id
          @fa_flag_check_review = true
        end
      end
    end
      
end

Spree::ReviewsController.class_eval do
  prepend ReviewsControllerExtensions
end

