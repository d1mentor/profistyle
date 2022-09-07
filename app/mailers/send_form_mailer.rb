class SendFormMailer < ApplicationMailer
    default from: "gerasimenkot92@gmail.com"

    def send_form
        @order = { name: params[:name], email: params[:email], subject: params[:subject], message: params[:message] }
        mail(to: "gerasimenkot92@gmail.com", subject: "profistyle.group контактная форма")
    end
    
end
