class Expression < ActiveRecord::Base

  self.primary_keys = 'gene', 'time', 'condition'

  validates :gene, presence: true
  validates :time, presence: true
  validates :condition, presence: true
  validates :replicate, presence: true
  validates :expression, presence: true  
end
