class Institution::DashboardsController < ApplicationController
  layout "institution"
  def index

    @total_scholarships = current_user.institution.scholarships.count
    @total_scholarships_active = current_user.institution.scholarships.published.count
    @total_scholarships_inactive = current_user.institution.scholarships.where(active: false).count


  end
end
