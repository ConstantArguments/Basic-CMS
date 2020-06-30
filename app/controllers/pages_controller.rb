class PagesController < ApplicationController
  # instance variables defined here used in views

  layout 'admin'

  # Controller filters #
  #----------------------

  # set this for these actions inside this controller
  before_action :confirm_logged_in
  before_action :find_subject
  before_action :set_page_count, :only => [:new, :create, :edit, :update]
  # the no longer needed code are commented out within the action methods

  # CRUD Actions #
  #-----------------------

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:name => "Add Page Name", :subject_id => @subject.id})
    # @page_count = Page.count + 1
    # @subjects = Subject.sorted
  end

  def create
    @page = Page.new(page_params)
    @page.subject = @subject # param for _form
    if @page.save
      flash[:notice] = "Page created sucessfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      # @page_count = Page.count + 1
      # @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    # @page_count = Page.count
    # @subjects = Subject.sorted
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated sucessfully."
      redirect_to(pages_path(@page, :subject_id => @subject.id))
    else
      # @page_count = Page.count
      # @subjects = Subject.sorted
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' deleted successfully."
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  private # won't be accessible outside of this class unless inherited

  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def set_page_count
    @page_count = @subject.pages.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end

end