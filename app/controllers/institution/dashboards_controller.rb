class Institution::DashboardsController < ApplicationController
  layout "institution"
   before_action :autorize_institution!
   before_action :authenticate_user!


  def index
    @total_scholarships = current_user.institution.scholarships.count
    @total_scholarships_active = current_user.institution.scholarships.published.count
    @total_scholarships_inactive = current_user.institution.scholarships.where(active: false).count

    @scholarships = current_user.institution.scholarships

    # Recherche textuelle (titre ou statut)
    if params[:search].present?
      @scholarships = @scholarships.search_by_name_and_status(params[:search])
    end

    # Filtrage complémentaire par statut (si status est un booléen)
    if params[:status].present?
      if params[:status] == "Actif"
        @scholarships = @scholarships.where(active: true)
      elsif params[:status] == "Inactif"
        @scholarships = @scholarships.where(active: false)
      end
    end
  end
   def autorize_institution!
    redirect_to root_path, alert: "Accès refusé." unless current_user&.institution?
  end
end
