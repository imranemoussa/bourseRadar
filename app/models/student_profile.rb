class StudentProfile < ApplicationRecord
  belongs_to :user

  validates :field_of_study, :current_level, :nationality, presence: true
  validates :birth_date, presence: true, if: -> { user.role == 'student' }

  scope :by_field_of_study, ->(field) { where(field_of_study: field) }
  scope :by_level, ->(level) { where(current_level: level) }
  scope :by_nationality, ->(nationality) { where(nationality: nationality) }
  scope :by_country, ->(country) { where(country: country) }

  # Méthode pour obtenir l'email depuis l'user associé
  def email
    user.email
  end
end
