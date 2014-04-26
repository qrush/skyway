class SearchesController < ApplicationController
  def index
    @search = Search.new(query: params[:query])
  end
end
