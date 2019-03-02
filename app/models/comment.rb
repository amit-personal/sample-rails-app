class Comment < ApplicationRecord
  # extend ActsAsTree::TreeView
  has_closure_tree
  # acts_as_tree order: 'created_at DESC'
  belongs_to :user
  belongs_to :link

  validates :body, presence: true
end
