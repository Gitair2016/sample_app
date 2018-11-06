class UsersController < ApplicationController
  before_action:logged_in_user, only:[:edit,:update,:index,:destory,:following,:followers]
  before_action:correct_user, only:[:edit,:update]
  before_action:admin_user, only:[:destory]
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page:params[:page])
  end  

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info]= "please check you email to activation"
      redirect_to root_url
    else
      render 'new'
    end
  end

   def edit
    @user = User.find(params[:id])
   end
 


  def update
    
    if @user.update_attributes(user_params)
      flash[:success]= "profile update"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destory
    flash[:success] = "user deleted"
    redirect_to users_url

  end 

    def following
      @title = "following"
      @user = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    end

    def followers
      @title = "followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end  


    private

      def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

     

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end  

      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end   


end
