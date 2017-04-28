class Message < ApplicationRecord

  belongs_to :user

  has_many :comments, :dependent => :destroy

  has_many :likes
  has_many :likedusers, through: :likes, dependent: :destroy, source: "user"
  has_many :subscribes
  has_many :subscribedusers, through: :subscribes, dependent: :destroy, source: "user"


  def last_comment_summary
    self.comments.last.try(:content).try(:truncate, 20)
  end

  scope :pending, ->{ where( status: "pending" ) }
  scope :completed, ->{ where( status: "completed" ) }

end
