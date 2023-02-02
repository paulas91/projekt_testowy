# Preview all emails at http://localhost:3000/rails/mailers/items_mailer
class ItemsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/items_mailer/reminder
  def reminder
    ItemsMailer.reminder
  end

end
