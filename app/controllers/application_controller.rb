class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Exception handle
  rescue_from ActionController::RoutingError,  with: :render_404
  rescue_from ActiveRecord::RecordNotFound,    with: :render_404

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/error_404", :status => 404, :layout => 'application', :content_type => 'text/html'
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end

    render :template => "errors/error_500", :status => 500, :layout => 'application'
  end
end
