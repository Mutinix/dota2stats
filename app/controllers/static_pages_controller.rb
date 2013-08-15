class StaticPagesController < ApplicationController
  def splash
    render :splash, :layout => false
  end
end
