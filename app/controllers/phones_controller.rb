class PhonesController < ApplicationController
  include PhonesHelper
  
  def search
    name = params['q']
    if name.nil?
      flash[:notice] = "Parameter 'q' was not passed"
      redirect_to action: 'index'
    else
      @phones = PhonesHelper.get_phone_names_json(name)
      respond_to do |format|
        format.json {render :json => @phones}
      end
    end
  end
  
  def compare
    @phones = []
    @query = params['phones']

    if @query.nil?
      flash[:notice] = "Parameter 'name_url' was not passed"
      redirect_to action: 'index'
    else
      @phones = PhonesHelper.get_all_phones(@query.split(','))
      render :index
    end
  end
  
  def index
    @query = nil
    @phones = []
  end
  
  def data
    name_url = params['name_url']
    if name_url.nil?
      flash[:notice] = "Parameter 'name_url' was not passed"
      redirect_to action: 'index'
    else
      @phone_data = PhonesHelper.get_phone_data(name_url)
      respond_to do |format|
        format.json {render :json => @phone_data}
      end
    end
  end
end

