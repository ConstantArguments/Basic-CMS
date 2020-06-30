class Page < ApplicationRecord

  # can be multiples, just not for the same subject
  acts_as_list :scope => :subject

  # relationship 1:M
  # option removes ActiveRecord validation for object presence
  belongs_to :subject, { :optional => false }
  has_many :sections

  # relationship M:N
  has_and_belongs_to_many :admin_users # join_table does not need to be specified

  # scope
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order('position ASC') }
  scope :newest_first, lambda { order('created_at DESC') }
  scope :search, lambda {|query| where(['name LIKE ?', "%#{query}%"])}

  # validation
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
  # for unique values by subject use ":scope => :subject_id"

end
