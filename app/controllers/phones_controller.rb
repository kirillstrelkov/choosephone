class PhonesController < ApplicationController
  include PhonesHelper

  def compare
    @description = DEFAULT_DESC
    @title = DEFAULT_TITLE
    @phones = []
    @commit = params[:commit]

    if @commit == 'clear'
      @query = nil
    else
      @query = params['phone_names']
    end

    if @query.nil? || @query.length == 0
      flash[:notice] = 'You did not enter any phone models' if @commit != 'clear'
      redirect_to action: 'index'
    else
      @phones = PhonesHelper.get_all_phones(@query.split(','))
      @title = @phones.map { |p| p[:name].strip }.join(' vs ')
      @description = DESC_PREFIX + ' ' + @title + ' ?'
      render :index
    end
  end

  def index
    @query = nil
    @description = DEFAULT_DESC
    @title = DEFAULT_TITLE
    @phones = []
  end
end
