namespace :scholarships do
  desc "Send deadline reminders for scholarships expiring soon"
  task send_deadline_reminders: :environment do
    Scholarship.active.expiring_soon.find_each do |scholarship|
      NotificationMailerJob.perform_later(scholarship.id, 'deadline_reminder')
    end
  end
  
  desc "Send weekly digest of new scholarships"
  task send_weekly_digest: :environment do
    scholarships = Scholarship.active.where(created_at: 1.week.ago..Time.current)
    # Implémentation du digest...
  end
end