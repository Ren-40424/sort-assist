class Workspace < ApplicationRecord
  validates :name, presence: true

  has_many :workspace_users
  has_many :users, through: :workspace_users
  has_many :sheets

  def made_by
    workspace_users.find_by(role_id: 1)&.user&.name
  end

  def user_role(id)
    workspace_users.find_by(user_id: id)&.role&.description
  end

  def users
    workspace_users.includes(:user).map do |record|
      { user: record.user, role: record.role }
    end
  end
end
