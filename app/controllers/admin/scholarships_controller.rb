class Admin::ScholarshipsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :autorize_admin!
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy]


  def index
    @scholarships = Scholarship.includes(:institution).order(created_at: :desc)
  end

  def show
  end

  def new
    @scholarship = Scholarship.new
  end

  def create
    @scholarship = Scholarship.new(scholarship_params)
    if @scholarship.save
      redirect_to admin_scholarship_path(@scholarship), notice: "Bourse créée avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @scholarship.update(scholarship_params)
      redirect_to admin_scholarship_path(@scholarship), notice: "Bourse mise à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scholarship.destroy
    redirect_to admin_scholarships_path, notice: "Bourse supprimee"
  end

  private
  def set_scholarship
    @scholarship = Scholarship.find(params[:id])
  end

  def scholarship_params
    params.require(:scholarship).permit(
      :institution_id, :title, :description, :requirements, :benefits,
      :level, :field_of_study, :country, :city, :pourcentage, :scholarship_type,
      :duration_months, :application_deadline, :program_start_date,
      :language, :age_min, :age_max, :gender_requirement, :external_application_url, :active
    )
  end

  def autorize_admin!
    redirect_to root_path, alert: "Accès refusé." unless current_user&.admin?
  end
end
