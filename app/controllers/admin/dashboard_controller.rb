class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :autorize_admin!
  def index
    @stats = {
      total_users: User.count,
      studients_count: User.where(role: 'student').count,
      institutions_count: User.where(role: 'institution').count,
      total_scholarships: Scholarship.count,
      active_scholarships: Scholarship.published.count,
      pending_scholarships: Scholarship.where(active: false).count,
      total_institutions: Institution.count
    }

    @recent_users = User.order(created_at: :desc).limit(6)
    @recent_scholarships = Scholarship.includes(:institution).order(created_at: :desc).limit(6)

  end

  private

  def autorize_admin!
    redirect_to root_path, alert: 'Vous n\'êtes pas autorisé à accéder à cette page.' unless current_user.admin?
  end
end
