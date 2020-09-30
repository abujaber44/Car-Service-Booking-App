class Reservation < ActiveRecord::Base
    belongs_to :user 
    validates :date, :time, :pick_up, :drop_off, presence: :true 
end
