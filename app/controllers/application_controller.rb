class ApplicationController < ActionController::Base
  include Pundit::Authorization
  layout 'application'
end
