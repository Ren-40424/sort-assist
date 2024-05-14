class Workspace < ApplicationRecord
  validates :name, presence: true

  has_many :workspace_users
  has_many :users, through: :workspace_users
end
