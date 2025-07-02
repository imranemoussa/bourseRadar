class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :scholarship, optional: true

  enum notification_type: {
    scholarship_deadline: 'scholarship_deadline',
    new_scholarship: 'new_scholarship',
    scholarship_match: "scholarship_match"
  }

  scope :unread, -> { where(read: false)}

  validates :title, presence: true
  validates :notification_type, presence: true
end
