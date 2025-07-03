class Institution < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :scholarships, dependent: :destroy

  validates :name, :country, :city, presence: true
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
end
