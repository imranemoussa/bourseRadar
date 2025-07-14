class Scholarship < ApplicationRecord
  belongs_to :institution
  has_many :notifications, dependent: :destroy

  include PgSearch::Model 

  pg_search_scope :search_by_keywords,
    against: [:title, :description, :field_of_study, :level],  
    using: {
      tsearch: { prefix: true, any_word: true },
      trigram: {}
    }
    pg_search_scope :search_by_name_and_status,
    against: [:title, :active],
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
  scope :not_expired, -> { where('application_deadline >= ?', Date.current) }
  scope :expiring_soon, -> { where(application_deadline: Date.current..3.days.from_now) }

  after_create :notify_matching_students
  after_update :check_deadline_notifications, if: :saved_change_to_application_deadline?

  # Méthode pour trouver les étudiants correspondants
  def matching_students
    students = StudentProfile.joins(:user)
    
    # Filtre par domaine d'étude (priorité 1)
    students = students.where(field_of_study: field_of_study) if field_of_study.present?
    
    # Filtre par niveau si spécifié (priorité 2)
    students = students.where(current_level: level) if level.present?
    
    # Filtre par pays si spécifié (priorité 3)
    students = students.where(country: country) if country.present?
    
    # Si aucun match strict, essayons juste par domaine
    if students.empty? && field_of_study.present?
      students = StudentProfile.joins(:user).where(field_of_study: field_of_study)
    end
    
    # En dernier recours, tous les étudiants
    if students.empty?
      students = StudentProfile.joins(:user)
    end
    
    students
  end


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
  def remaining_days
    return 0 unless application_deadline.present?

    days = (application_deadline - Date.today).to_i
    days.positive? ? days : 0
 end


 private
 def notify_matching_students
  NotificationMailerJob.perform_later(self.id, 'matching_scholarship')
 end

 def check_deadline_notifications
  if deadline_approaching?
    NotificationMailerJob.perform_later(self.id, 'deadline_reminder')
  end
 end

 def deadline_approaching?
  application_deadline.present? && application_deadline <= 3.days.from_now && application_deadline > Date.current
 end
end
