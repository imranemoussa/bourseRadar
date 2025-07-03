class Scholarship < ApplicationRecord
  belongs_to :institution
  has_many :notifications, dependent: :destroy

  include PgSearch::Model

  pg_search_scope :search_by_keywords,
    againt: [:title, :description, :field_of_study, :level],
    using: {
      tsearch: { prefix: true, any_word: true },
      trigram: {}
    }

  validates :title, presence: true, length: { minimum: 5, maximum: 100}
  validates :description, presence: true, length: { minimum: 50 }
  validates :application_deadline, presence: true
  validates :application_deadline, comparison: { greater_than: Date.current, message: "La date limite de candidature doit être dans le futur" }
  validates :pourcentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, allow_blank: true
  validates :duration_months, numericality: { greater_than: 0}, allow_blank: true

  validates :age_min, numericality: { greater_than: 0}, allow_blank: true
  validates :age_max, numericality: { greater_than: 0}, allow_blank: true
  validates :external_application_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true

  scope :published, -> { where(active: true) }

  def days_left
    if application_deadline
      (application_deadline - Date.today).to_i
    else
      nil
    end
  end

  def matches_student_profile?(profile)
    if profile
      if field_of_study == profile.field_of_study
        if level == "" || level.nil?
          true
        elsif level == profile.current_level
          true
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end
end
