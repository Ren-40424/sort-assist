class Workspace < ApplicationRecord
  validates :name, presence: true

  has_many :workspace_users
  has_many :users, through: :workspace_users

  def made_by
    workspace_users.find_by(role_id: 1)&.user.name
  end
end
