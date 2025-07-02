class StudentProfile < ApplicationRecord
  belongs_to :user

  validates :field_of_study, :current_level, :nationality, presence: true
  validates :birth_date, presence: true, if: -> { user.role == 'student' }

end
