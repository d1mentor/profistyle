class SendFormMailer < ApplicationMailer
    default from: "gerasimenkot92@gmail.com"

    def send_form
        @name = params[:name]
        @email = params[:email]
        @subject = params[:subject]
        @message = params[:message]
        mail(to: ["gerasimenkot92@gmail.com", "biuro@profistyle.group"], subject: "сообщение с сайта profistyle.group")
    end
    
end
