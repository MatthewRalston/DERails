class Expression < ActiveRecord::Base

  self.primary_keys = 'gene', 'time', 'condition'
  validates :gene, presence: true
  validates :time, presence: true, inclusion: {in: [15,75,150,270]}
  validates :condition, presence: true, inclusion: {in: %w(Untreated Butyrate Butanol)}
  validates :replicate, presence: true, inclusion: {in: [1,2,3]}
  validates :expression, presence: true  
end
