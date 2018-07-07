class SearchesController < ApplicationController
  def index
    @q = params[:q]
    @tweets = @q.present? ? $client.search(@q, result_type: 'mixed').take(20) : []
  end
end
