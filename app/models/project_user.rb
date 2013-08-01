class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  ROLE = {
    viewer: 1,
    owner:  10
  }

end
