# Preview all emails at http://localhost:3000/rails/mailers/leads_mailer
class LeadsMailerPreview < ActionMailer::Preview

  def send_lead_email
    project = Project.new(
      name: 'Proyecto X', type_project: 0, address: 'Av 32', has_vis: true, private_area: 20.2,
      built_area: 60.2, bathrooms: 1, has_parking: false, sales_room_emails: "cami.andre469@gmail.com,camila.herrera@vecindario.com"
    )
    user = User.new(first_name: 'Juana María', last_name: 'Gómez Prieto', email: 'juanmago@gmail.com', phone: '317 452 2569', password: 'lg123456')
    LeadsMailer.send_lead_email(project, user);
  end

end
