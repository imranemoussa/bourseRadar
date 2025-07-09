class Institution::ScholarshipsController < ApplicationController
    layout "institution"
   before_action :autorize_institution!
   before_action :authenticate_user!
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy]


  def index
    @scholarships= current_user.institution.scholarships
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
def edit
  end

  def update
    if @scholarship.update(scholarship_params)
      redirect_to institution_scholarships_path(@scholarship), notice: "Bourse mise à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scholarship.destroy
    redirect_to institution_scholarships_path, notice: "Bourse supprimee"
  end

  private
  def set_scholarship
    @scholarship = Scholarship.find(params[:id])
  end

 def scholarship_params
    params.require(:scholarship).permit(
     :title, :description, :requirements, :benefits,
      :level, :field_of_study, :country, :city, :pourcentage, :scholarship_type,
      :duration_months, :application_deadline, :program_start_date,
      :language, :age_min, :age_max, :gender_requirement, :external_application_url, :active
    )
  end
   def autorize_institution!
    redirect_to root_path, alert: "Accès refusé." unless current_user&.institution?
  end
end
