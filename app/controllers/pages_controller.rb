class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @routes = Route.all.where.not(name: nil)
    # @best_routes = Route.order(votes: :desc).first(5)
  end
end
