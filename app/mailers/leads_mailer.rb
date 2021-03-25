class LeadsMailer < ApplicationMailer

  def send_lead_email(project, user)
    @project = project
    @user = user
    addresses = project.sales_room_emails.split(',')
    addresses.each do |n|
      mail({
             to: n,
             subject: 'Se están fijando en tu proyecto'
           })
    end
  end

end
