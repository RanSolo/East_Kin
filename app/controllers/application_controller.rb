class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_welcome
  after_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    
  end
  def set_welcome
    @welcome = Welcome.find(1)
  end
end
