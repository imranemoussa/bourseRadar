class NotificationMailerJob < ApplicationJob
  queue_as :default

  def perform(scholarship_id, notification_type)
    Rails.logger.info "🔄 Job started: scholarship_id=#{scholarship_id}, type=#{notification_type}"
    
    scholarship = Scholarship.find(scholarship_id)
    Rails.logger.info "📚 Scholarship found: #{scholarship.title}"
    
    case notification_type
    when 'matching_scholarship'
      send_matching_scholarship_notifications(scholarship)
    when 'deadline_reminder'
      send_deadline_reminder_notifications(scholarship)
    end
  end

  private

 def send_matching_scholarship_notifications(scholarship)
  matching_students = scholarship.matching_students
  
  Rails.logger.info "👥 Found #{matching_students.count} matching students"
  
  matching_students.find_each do |student|
    Rails.logger.info "📧 Sending email to: #{student.email}"
    begin
      ScholarshipNotificationMailer.matching_scholarship(student, scholarship).deliver_now
      Rails.logger.info "✅ Email sent successfully to #{student.email}"
    rescue => e
      Rails.logger.error "❌ Error sending email to #{student.email}: #{e.message}"
    end
  end

    # Matching plus flexible : commençons par le field_of_study uniquement
    matching_students = StudentProfile.joins(:user)
                                     .where(field_of_study: scholarship.field_of_study)
    
    # Si aucun match par field_of_study, essayons avec tous les étudiants
    if matching_students.empty?
      Rails.logger.info "⚠️  No students match field_of_study. Trying all students..."
      matching_students = StudentProfile.joins(:user)
    end
    
    Rails.logger.info "👥 Found #{matching_students.count} matching students"
    
    # Debug des critères
    Rails.logger.info "🔍 Scholarship criteria:"
    Rails.logger.info "  - Field: #{scholarship.field_of_study}"
    Rails.logger.info "  - Level: #{scholarship.level}"
    Rails.logger.info "  - Country: #{scholarship.country}"
    
    matching_students.find_each do |student|
      Rails.logger.info "📧 Sending email to: #{student.email}"
      Rails.logger.info "  - Student Field: #{student.field_of_study}"
      Rails.logger.info "  - Student Level: #{student.current_level}"
      Rails.logger.info "  - Student Country: #{student.country}"
      
      begin
        ScholarshipNotificationMailer.matching_scholarship(student, scholarship).deliver_now
        Rails.logger.info "✅ Email sent successfully to #{student.email}"
      rescue => e
        Rails.logger.error "❌ Error sending email to #{student.email}: #{e.message}"
      end
    end
    end

  def send_deadline_reminder_notifications(scholarship)
    all_students = StudentProfile.joins(:user)
    Rails.logger.info "👥 Sending deadline reminders to #{all_students.count} students"
    
    all_students.find_each do |student|
      Rails.logger.info "📧 Sending deadline reminder to: #{student.email}"
      begin
        ScholarshipNotificationMailer.deadline_reminder(student, scholarship).deliver_now
        Rails.logger.info "✅ Deadline reminder sent to #{student.email}"
      rescue => e
        Rails.logger.error "❌ Error sending deadline reminder to #{student.email}: #{e.message}"
      end
    end
  end

end