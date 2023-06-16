class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @min_distance = 0
    @max_distance = 100
    @routes = Route.all.where.not(name: nil)
    @best_routes = Route.includes(:favorites)
                        .left_joins(:favorites)
                        .group(:id)
                        .where.not(name: nil)
                        .order('COUNT(favorites.id) DESC')
                        .limit(5)
  end
end
