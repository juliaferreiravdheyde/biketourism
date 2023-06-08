class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :route

  def done!
    return if done

    update(done: true)
  end
end
