class SubjectsController < ApplicationController
  # instance variables defined here used in views

  layout 'admin'

  # Controller filters #
  #----------------------

  # set this for these actions inside this controller
  before_action :confirm_logged_in

  # CRUD Actions #
  #-----------------------

  # Read
  def index
    logger.debug("*** Testing the logger. ***")
    # .sorted from subject model (sorted by position)
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  # Create
  def new
    # defining here (vs within view code) allows default table variables to be set (from db schema)
    # also can set defaults on form here in a hash
    @subject = Subject.new({:name => "Default"})
    # used with new (via _form) view for form selection, must also be in create below
    @subject_count = Subject.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, flash hash and redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      # If save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1 # must be here and new above
      render('new') # keeps user entered data in fields
    end
  end

  # Update
  def edit
    @subject = Subject.find(params[:id])
    # used with edit (via _form) view for form selection, also must be in update below
    @subject_count = Subject.count
  end

  def update
    # Find object using form parameters
    @subject = Subject.find(params[:id])
    # Update/Save the object
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to show detail action
      flash[:notice] = "Subject updated successfully."
      redirect_to(subjects_path(@subject))
    else
      # If save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count # must be here and edit above
      render('edit') # keeps user entered data in fields
    end
  end

  # Destroy
  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' deleted successfully."
    redirect_to(subjects_path) # return to index action
  end

  private # won't be accessible outside of this class unless inherited

  def subject_params
    # whitelist for use in mass assignment, and required, for this controller
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

end
