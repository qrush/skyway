class SearchesController < ApplicationController
  def show
    @search = Search.new(params[:query])
  end
end
