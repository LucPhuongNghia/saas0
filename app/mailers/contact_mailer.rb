class ContactMailer < ActionMailer::Base
  default to: 'lucphuongnghia@gmail.com'
  
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    
    mail(from: email, subject: "Message from contact")
  end
end