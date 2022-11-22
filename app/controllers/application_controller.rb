class ApplicationController < ActionController::Base
  include Pundit::Authorization
  layout 'application'

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
