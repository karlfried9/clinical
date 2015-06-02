class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :organization

  has_one :profile, class_name: "UserProfile", dependent: :destroy
  has_many :permissions, dependent: :destroy

  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: "Doctor" if self.role.nil?
  end

  def doctor?
    self.role.name == "Doctor"
  end

  def clinic_manager?
    self.role.name == "Clinic Manager"
  end

  def super_admin?
    self.role.name == "Super Admin"
  end

  # getter and setter
  def set_role(name)
    self.role = Role.find_by name: name if self.role.nil?
  end
end
