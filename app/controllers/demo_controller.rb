class DemoController < ApplicationController
  # A controller is able to render a template, or redirect, to a new location.
   # And a redirect is actually just telling the browser that it should quickly go to a new URL

  # Transfer data from the controller to the view is exclusively through instance variables.
    # The controller has to set everything up ahead of time so that the view can present it
    # and then send it back to the browser and move on. Communication does not work both ways.
    # You can't go back and get something that you forgot.

  layout 'application'

  def index
    # dafault action is go to view/demo/index if nothig written
      # this can also be written 3 ways (all mean the same):
        # render(:template => 'demo/index')
        # render('demo/index')
        render('index')
    # write something else to override
      # render('hello')
  end

  def hello
    @array = [1, 2, 3, 4, 5]

    # params values are always strings
    @id = params['id'] # written as string, symbol would also work the same
    @page = params[:page] # written as symbol, string would also work the same

    render('hello')
  end

  def other_hello
    # redirect tells browser to request somthing different
      # redirect_to(:controller => 'demo', :action => 'index')
    # can be simplified to the folowing since already in DemoController
      redirect_to(:action => 'index')
  end

  def google
    # redirects can be to anywhere even external sources
    # just make sure route is defined
      redirect_to('http://google.com')
  end

  def escape_output

  end

end
