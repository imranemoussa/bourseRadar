class ScholarshipNotificationMailer < ApplicationMailer
    default from: 'notifications@scholarships-app.com'

  def matching_scholarship(student_profile, scholarship)
    @student = student_profile
    @scholarship = scholarship
    @user_name = @student.user.full_name || @student.user.email.split('@').first
    @institution = @scholarship.institution

    mail(
      to: @student.email,
      subject: "Nouvelle bourse disponible dans votre domaine : #{@scholarship.title}"
    )
  end

  def deadline_reminder(student_profile, scholarship)
    @student = student_profile
    @scholarship = scholarship
    @user_name = @student.user.full_name || @student.user.email.split('@').first
    @institution = @scholarship.institution
    @days_remaining = (@scholarship.application_deadline - Date.current).to_i

    mail(
      to: @student.email,
      subject: "Rappel : Date limite approche - #{@scholarship.title}"
    )
  end
end
