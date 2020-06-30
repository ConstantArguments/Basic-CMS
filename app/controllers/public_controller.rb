class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation

  def index
    # intro text
  end

  def show
    @page = Page.visible.where(:permalink => params[:permalink]).first
    if @page.nil?
      redirect_to(root_path) # (:action => 'index') is root_path route helper
    else
      # display page content with show.html.erb
    end
  end

  private

  def setup_navigation
    @subjects = Subject.visible.sorted
  end

end
