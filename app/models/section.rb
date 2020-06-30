class Section < ApplicationRecord

  # can be multiples, just not for the same page
  # acts_as_list :scope => :page

  # relationship 1:M
  belongs_to :page
  # relationship "rich"
  has_many :section_edits
  has_many :admin_users, :through => :section_edits

  # scope
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

  # constant
  CONTENT_TYPES = ['text', 'HTML']

  # validations
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content

end
