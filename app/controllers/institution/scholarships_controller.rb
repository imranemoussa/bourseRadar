class Institution::ScholarshipsController < ApplicationController
    layout "institution"

  def index
  end

  def show
  end

  def new
  @institution = current_user.institution
  @scholarship = @institution.scholarships.new
  end

  def create
  @institution = current_user.institution
  @scholarship = @institution.scholarships.new(scholarship_params)
  if @scholarship.save
    redirect_to institution_scholarships_path, notice: " Bourse Créé avec succès."
  else
    render :new, status: :unprocessable_entity
  end
end

 def scholarship_params
    params.require(:scholarship).permit(
     :title, :description, :requirements, :benefits,
      :level, :field_of_study, :country, :city, :pourcentage, :scholarship_type,
      :duration_months, :application_deadline, :program_start_date,
      :language, :age_min, :age_max, :gender_requirement, :external_application_url, :active
    )
  end
end
