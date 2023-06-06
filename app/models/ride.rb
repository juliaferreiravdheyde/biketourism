class Ride < ApplicationRecord
  belongs_to :user, :route
end
