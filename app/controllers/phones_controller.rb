class PhonesController < ApplicationController
  def index
  end

  def compare
    params['phone']
  end
end
