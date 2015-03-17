class Gene < ActiveRecord::Base

  validates :gene, presence: true
end
