class AdminMailer < Merb::MailController

  def new_user
    @user = params[:user]
    render_mail
  end
  
end
