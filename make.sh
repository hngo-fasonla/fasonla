bundle install --without production
#rails g spree:install --sample=false --seed=false
rails g spree:install
#In config/initializer/spree.rb: LegacyUser -> Usersp
bundle exec rails g spree_admin_roles_and_access:install
bundle exec rake spree_roles:permissions:populate
#In vendor/assets/stylesheets/spree/frontend/:
#Remove *= require store/spree_admin_roles_and_access
#Remove *= require admin/spree_admin_roles_and_access
#Remove //= require admin/spree_admin_roles_and_access
#Remove //= require store/spree_admin_roles_and_access
rails g spree_reviews:install
rails g spree_editor:install
rails g ckeditor:install --orm=active_record --backend=paperclip && rake db:migrate
#In config/initializers/ckeditor.rb: config.authorize_with :cancan, Spree::Ability
rails generate spree_multi_currency:install
rails g spree_i18n:install
bundle exec rails g spree_social_products:install
bundle exec rails g spree_wishlist:install
