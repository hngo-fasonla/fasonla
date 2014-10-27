module ProductsControllerExtensions
  def show
    super
    show_work
  end

  protected
    def show_work
      # Display name of Seller
      @fa_seller = Spree::User.find(@product.user_id).email
  
      # Points of Seller, points = avg(all ratings products)
  
      # Products of Seller, with user_id = {@product.user_id}
      fa_products = Spree::Product.search(user_id_eq: @product.user_id).result
  
      @fa_max_point = 0
      @fa_avg_points = 0
  
      # Seller exist product
      if fa_products.count != 0
        fa_total_avg_rating = 0
        fa_flag = false
        fa_count_reviews = 0
  
        # Read fa_products, count number product review, total, flag check exist product are review
        fa_products.each do |fa_product|
          if fa_product.reviews_count != 0
          fa_flag = true
          fa_count_reviews += 1
          fa_total_avg_rating += fa_product.avg_rating
          end
        end
  
        # Seller exist product are review
        if fa_flag == true
          @fa_max_point = 100
          @fa_avg_points = ((fa_total_avg_rating*@fa_max_point)/(fa_count_reviews*5)).to_i
        end
      end
  
    end
end

Spree::ProductsController.class_eval do
  prepend ProductsControllerExtensions
end

