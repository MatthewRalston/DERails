class Expressiondifference < ActiveRecord::Base
  self.primary_keys = 'gene', 'time1', 'condition1', 'time2', 'condition2'

  validates :gene, presence: true
  validates :time1, inclusion: {in: [15,75,150,270]}, allow_blank: true
  validates :condition1, inclusion: {in: %w(Untreated Butyrate Butanol)}, allow_blank: true
  validates :time2, inclusion: {in: [15,75,150,270]}, allow_blank: true
  validates :condition2, inclusion: {in: %w(Untreated Butyrate Butanol)}, allow_blank: true
  validates :foldchange, presence: true
  validates :pval, presence: true

end
