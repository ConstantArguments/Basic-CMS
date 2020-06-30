class AdminUser < ApplicationRecord # this was previously class User

  # tells rails to use a different table name
  # self.table_name = "admin_users"
    # this also allows use of legacy tables
    # option I used was to rename this Class to "AdminUser" and rename file to "admin_user.rb"

  # Secure Password authentication requires gem bcrypt and "password_digest" column in table
  has_secure_password

  # relationship M:N
  has_and_belongs_to_many :pages # join_table does not need to be specified
  # relationship "rich"
  has_many :section_edits
  has_many :sections, :through => :section_edits

  # scope
  scope :sorted, lambda { order('last_name ASC, first_name ASC')}

  # constant
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

  # validations
  # "long form" validations
  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  # "sexy" validations
  validates :first_name, :presence => true,
												 :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 },
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  # custom validations defined under "private"
  validate :username_is_allowed
  validate :no_new_users_on_wednesday, :on => :create

  def name
    "#{first_name} #{last_name}"
  end

  private

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use.")
    end
  end

  def no_new_users_on_wednesday
    if Time.now.wday == 3
      # ":base" so it's not attached to an attribute. It's just a general error on the object.
      errors.add(:base, "No new users on Wednesdays.")
    end
  end

end
