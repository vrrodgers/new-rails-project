class Wiki < ApplicationRecord
  belongs_to :user

  validates :user, presence: true


  def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to wikis_path
     end
   end
end
