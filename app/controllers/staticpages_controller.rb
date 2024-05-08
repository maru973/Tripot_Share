class StaticpagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top; end

  def privacy_policy; end

  def terms_of_service; end

  def contact_us; end
end
