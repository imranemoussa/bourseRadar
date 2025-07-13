class ScholarshipsController < ApplicationController
    def index
        @countries = Scholarship.published.distinct.pluck(:country).compact.sort
        @levels = Scholarship.published.distinct.pluck(:level).compact.sort
        @fields_of_study = Scholarship.published.distinct.pluck(:field_of_study).compact.sort
        if params[:query].present?
            @scholarships = Scholarship.search_by_keywords(params[:query])
        else
            @scholarships = Scholarship.all
        end
    end

    def show
       @scholarship=Scholarship.find(params[:id])
    end

    def send_matching_notifications
    @scholarship = Scholarship.find(params[:id])
    NotificationMailerJob.perform_later(@scholarship.id, 'matching_scholarship')
    redirect_to @scholarship, notice: 'Notifications envoyées aux étudiants correspondants.'
  end
  
  def send_deadline_reminders
    @scholarship = Scholarship.find(params[:id])
    NotificationMailerJob.perform_later(@scholarship.id, 'deadline_reminder')
    redirect_to @scholarship, notice: 'Rappels de date limite envoyés.'
  end
    
end
