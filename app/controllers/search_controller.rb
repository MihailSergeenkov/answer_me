class SearchController < ApplicationController
  respond_to :html

  def search
    authorize! :read, @results
    respond_with(@results = Search.query(params[:query], params[:condition]))
  end
end
