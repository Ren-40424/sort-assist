class Role < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Admin',  description: 'あなたはこのワークスペースの作成者です' },
    { id: 2, name: 'Editor', description: 'あなたはこのワークスペース内で編集可能です' },
    { id: 3, name: 'Viewer', description: 'あなたはこのワークスペースを閲覧できます' }
  ]

  include ActiveHash::Associations
  has_many :workspace_users
end
