class PhonesController < ApplicationController
  include PhonesHelper
  before_action :set_default_data

  def compare
    commit = params[:commit]

    @query = commit == 'clear' ? nil : params['phone_names']

    if @query.nil? || @query.length == 0
      flash[:notice] = 'You did not enter any phone models' if commit != 'clear'
      redirect_to action: 'index'
    else
      @phones = get_all_phones(@query.split(','))
      @title = @phones.map { |p| p[:name].strip }.join(' vs ')
      @description = DESC_PREFIX + ' ' + @title + ' ?'
      render :index
    end
  end

  def index
  end

  private

  def set_default_data
    @query = nil
    @description = DEFAULT_DESC
    @title = DEFAULT_TITLE
    @phones = []
  end
end
