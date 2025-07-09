class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update, :show]

  def new
    @profile = current_user.build_student_profile if current_user.student?
  end

  def create
    if current_user.student?
      @profile = current_user.build_student_profile(profile_params)
      if @profile.save
        redirect_to profile_path, notice: "Profil étudiant créé avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    # @profile déjà défini par set_profile
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    # @profile déjà défini par set_profile
  end

  private

  def set_profile
    @profile = current_user.student_profile
    unless @profile
      redirect_to new_profile_path, alert: "Veuillez d'abord créer votre profil."
    end
  end


  def profile_params
    params.require(:student_profile).permit(:birth_date, :nationality, :current_level, :current_institution, :field_of_study, :bio, :address, :city, :country)
  end
end