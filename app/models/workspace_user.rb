class WorkspaceUser < ApplicationRecord
  validates :user,      presence: true
  validates :workspace, presence: true
  validates :role,      presence: true, numericality: { only_integer: true, less_than_or_equal_to: 3 }

  belongs_to :user
  belongs_to :workspace

  extend ActiveHash::Association::ActiveRecordExtensions
  belongs_to :role
end
