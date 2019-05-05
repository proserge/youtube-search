class YoutubeSearchController < ApplicationController
  def show
    @show_results = SearchExecutor.new.call
  end
end
