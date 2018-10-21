class Wiki < ApplicationRecord
  belongs_to :user

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]


  def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to wikis_path
     end
   end
end
