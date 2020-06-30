class SectionEdit < ApplicationRecord

  # relationship "rich"
  belongs_to :admin_user
  belongs_to :section

end
