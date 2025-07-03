class ProfilesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    if current_user.student?
      @profile = current_user.student_profile
    else
      @profile = current_user.institution
    end
  end

  def profile_params
    if current_user.student?
      params.require(:student_profile).permit(
        :birth_date,
        :natinality,
        :current_level,
        :current_institution,
        :field_of_study,
        :bio,
        :address,
        :city,
        :country
      )
    elsif current_user.institution?
       params.require(:institution).permit(
        :name, :description, :country, :city, :website,
        :contact_email, :contact_phone, :logo_url
      )
    else
      {}
    end
  end
end
