class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :scholarship, optional: true

  NOTIFICATION_TYPES = %w[
  scholarship_deadline
  new_scholarship
  scholarship_match
  ].freeze

  validates :notification_type, presence: true, inclusion: { in: NOTIFICATION_TYPES }


  scope :unread, -> { where(read: false)}

  validates :title, presence: true
  validates :notification_type, presence: true
end
