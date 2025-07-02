class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :student_profile, dependent: :destroy
  has_one :institution, dependent: :destroy
  has_many :notifications, dependent:  :destroy

  VALID_ROLES = %w[student institution admin]

  validates :role, inclusion: { in: VALID_ROLES, message: "%{value} n'est pas un rôle valide" }

  validates :first_name, :last_name, presence: true
  validates :phone, format: { with: /\A[\+]?[0-9\-\s\(\)]+\z/, message: "Format de numero invalide" }, allow_blank: true
  validates :role, presence: true

  after_create :create_profile

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def create_profile
    if role == 'student'
      create_student_profile!
    elsif role == 'institution'
      create_institution!
    end
  end
  
end
