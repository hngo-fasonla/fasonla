class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError,
                ActionController::UnknownController, 
                ::AbstractController::ActionNotFound, 
                ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end
 
  private
    def render_error(status, exception)
      @exception = exception
      @url = request.url
      sendmail(status, exception, @url)
      respond_to do |format|
        format.html { render template: "errors/error_#{status}", status: status }
        format.json { render json: @status }
        format.all { render nothing: true, status: status }
      end
    end
    
    def sendmail(status, exception, url)
      user = spree_current_user.email
      Emailer.createmail(user, status, exception, url).deliver
    end
  
end
