# frozen_string_literal: true

class YoutubeSearchController < ApplicationController
  def show
    @show_results = SearchExecutor.new.call
  end
end
