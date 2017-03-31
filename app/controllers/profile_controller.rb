class ProfileController < ApplicationController
  def show
    
  end

  def edit
  end

  def update
    user = current_user
    #params[:user] => {name: "bob", email:"bob@examle.com"}
    user.update(params[:user])
  end
  private
  #外部から渡されるパラメーターをそのまま信用せず、
  #ホワイトリスト方式で検査する
  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :admin)
    else
      params.require(:user).permit(:name, :email)
    end
  end
end
