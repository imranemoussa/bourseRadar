class InstitutionsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :authorize_user!, only: [:new, :create, :edit, :update]
  def index
    @institutions = Institution.all
  end

  def show
    #@institution = Institution.find(params[:id])
  end

  def scholarships
    @institution = Institution.find(params[:id])
    @scholarships = @institution.scholarships.published.order(created_at: :desc)
  end

  def new
    @institution = Institution.new
  end

  def create
    institution_params = params.require(:institution).permit(
      :user_id,
      :name,
      :description,
      :country,
      :city,
      :website,
      :contact_email,
      :contact_phone,
      :logo_url
    )

    @institution = Institution.new(institution_params)
    @institution.user = current_user
    if @institution.save
      redirect_to @institution, notice: "Institution créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])
    institution_params = params.require(:institution).permit(
      :name,
      :description,
      :country,
      :city,
      :website,
      :contact_email,
      :contact_phone,
      :logo_url
    )

    if @institution.update(institution_params)
      redirect_to @institution, notice: "Institution mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def authorize_user!
    unless current_user.institution? || current_user.admin?
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page."
    end
  end
end
