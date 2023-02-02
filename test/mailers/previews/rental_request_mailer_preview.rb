# Preview all emails at http://localhost:3000/rails/mailers/rental_request_mailer
class RentalRequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/rental_request_mailer/ask
  def ask
    RentalRequestMailer.ask
  end

end
