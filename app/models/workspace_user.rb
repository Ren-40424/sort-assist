class WorkspaceUser < ApplicationRecord
  validates :user_id,         presence: true
  validates :workspace_id,    presence: true
  validates :role_id,         presence: true, numericality: { only_integer: true, less_than_or_equal_to: 3 }

  belongs_to :user
  belongs_to :workspace

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :role
end
