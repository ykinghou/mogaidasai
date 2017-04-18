class Job < ApplicationRecord
   belongs_to :user
   validates :title, :description, presence: true
   validates :wage_upper_bound, presence: true
   validates :wage_lower_bound, presence: true
   validates :wage_lower_bound, numericality: {greater_than: 0}

   has_many :job_relationships
   has_many :members, through: :job_relationships, source: :user
end
