class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @routes = Route.all.where.not(name: nil)
    @best_routes = Route.includes(:favorites)
                        .left_joins(:favorites)
                        .group(:id)
                        .where.not(name: nil)
                        .order('COUNT(favorites.id) DESC')
                        .limit(5)
  end
end
