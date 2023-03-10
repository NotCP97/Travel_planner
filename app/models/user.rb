
  class User < ApplicationRecord
    has_secure_password

    has_many :trips

    validates :first_name, presence: {message: "First name field is empty."}
    validates :last_name, presence: {message: "Last name field is empty."}
    validates :email, uniqueness: {message: "This email is already registered."}

    def joined
      self.created_at.strftime("%B %e, %Y")
    end

    def upcoming_trips
      upcoming = self.trips.select do |trip|
        trip.start_date >= Date.current
      end

      upcoming.sort_by do |trip|
        trip.start_date
      end
    end

    def past_trips
      past = self.trips.select do |trip|
        trip.start_date < Date.current
      end

      past.sort do |x, y|
        y.start_date <=> x.start_date
      end

    end

    def next_trip
      dates = []

      upcoming_trips.each do |trip|
        dates << trip.start_date
      end

      foundTrip = upcoming_trips.find do |trip|
        trip.start_date === dates.min
      end
    end

    def daysLeftTill
      if next_trip == []
        return 0
      else
        (next_trip.start_date - Date.current).to_i + 1
      end

    end
  end

