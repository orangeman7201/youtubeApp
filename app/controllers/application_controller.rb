class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :reqire_login
end
