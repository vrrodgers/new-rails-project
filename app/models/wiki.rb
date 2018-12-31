class Wiki < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  has_many :collaborators, inverse_of: :wiki
   accepts_nested_attributes_for :collaborators, 
                                 allow_destroy: true,
                                 reject_if: lambda { |attrs| attrs['user_id'].blank?}
   has_many :users, through: :collaborators


  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end

  scope :all_public_wikis, -> { where(private: false).or(Wiki.where(private: nil))}
  
  scope :own_any_wikis, -> { where(user_id: User.current.id)}

end
