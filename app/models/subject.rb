class Subject < ApplicationRecord
  # gem - provides the capabilities for sorting and reordering a number of objects in a list. The class that has this specified needs to have a "position" column defined as an integer on the mapped database table.
  acts_as_list

  # relationship 1:M, note: page puralized
  has_many :pages

  # scopes are querys defined in model
    # defined using ActiveRelation query methods
    # can be called like ActiveRelation methods
    # can acccept parameters
    # requires lambda syntax
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }

  # Because this is dynamic data, it might be coming from a user,
    # I wanna make sure that I use the question mark form in order to sanitize it (no injecting Hacker code)
  # percent signs on either side of query will indicate to SQL that it should use wildcard matching
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

   # these will not run until called, examples:
    # Subject.invisible
    # Subject.visible.sorted
    # Subject.search("Initial")

  # form validation
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
    # validates_presence_of vs. validates_length_of :minimum => 1
    # different error messages: "can't be blank" or "is too short"
    # validates_length_of allows strings with only spaces!

end
