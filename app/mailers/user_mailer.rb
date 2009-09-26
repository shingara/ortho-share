class UserMailer < Merb::MailController

  def account_activate
    @user = params[:user]
    render_mail
  end
  
end
