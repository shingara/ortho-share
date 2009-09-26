class AdminMailer < Merb::MailController

  def new_user
    @user = params[:user]
    render_mail
  end

  def new_document
    @document = params[:document]
    render_mail
  end
  
end
