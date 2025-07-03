class Admin::InstitutionsController < ApplicationController
  before_action :authenticate_user!
  before_action :autorize_admin!
  before_action :set_institution, only: [:show, :edit, :update, :destroy]


  # Actions for managing institutions
  def index
    @institutions = Institution.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @institution = Institution.new
    @institution.build_user
  end

  def create
    @institution = Institution.create(institution_params)
    @institution.user.role = 'institution' if @institution.user.present?
    if @institution.save
      redirect_to admin_institution_path(@institution), notice: "Institution créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @institution = Institution.update(institution_params)
      redirect_to admin_institution_path(@institution), notice: "Institution mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @institution.destroy
    redirect_to admin_institutions_path, notice: "Institution supprimee avec succès."
  end

  private

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def institution_params
    params.require(:institution).permit(:name, :description, :city, :country, :website, :contact_email, :contact_phone, :logo_url, user_attributes: [:email, :first_name, :last_name, :phone, :password, :password_confirmation])
  end

  def autorize_admin!
    redirect_to root_path, notice: "Vous n'avez pas le droit d'accéder à cette page." unless current_user.admin?
  end
end
