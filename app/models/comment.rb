class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :application

  attr_accessible :body, :application_id

  validates :user_id, :application_id, :presence => true

  validates :body, :presence => true, :length => { :maximum => 2000 }

  validate :user_is_member_or_key_member

  def user_is_member_or_key_member
    unless user && user.member_or_key_member?
      errors.add(:user, 'is not a member')
    end
  end
end