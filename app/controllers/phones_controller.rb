class PhonesController < ApplicationController
  include PhonesHelper
  before_action :set_default_data

  def compare
    commit = params[:commit]

    @query = commit == 'clear' ? nil : params['phone_names']

    if @query.nil? || @query.length == 0
      flash[:notice] = t('flash.no_phones_entered') if commit != 'clear'
      redirect_to phones_index_path
    else
      phones = @query.split(',').map(&:strip).delete_if(&:empty?).uniq
      @phones = get_all_phones(phones)
      @title = @phones.map { |p| p[:name].strip }.join(' vs ')
      @description = t('page.description_prefix') + ' ' + @title + ' ?'
      render :index
    end
  end

  def index
  end

  private

  def set_default_data
    @query = nil
    @description = t('page.description')
    @title = t('page.title')
    @phones = []
  end
end
