class UsersController
  def show
    @user = db.load params[:id]
  end
end