class HomeController < ApplicationController
  def index
    @recent_scholarships = Scholarship.published.includes(:institution).order(created_at: :desc).limit(10)

    @total_scholarships = Scholarship.published.count
    @total_institutions = Institution.count
    @countries_count = Scholarship.select(:country).distinct.count

    if params[:search].present?
      @scholarships = Scholarship.published.search_by_keywords(params[:search]).includes(:institution)

      @scholarships = @scholarships.where(country: params[:country]) if params[:country].present?
      @scholarships = @scholarships.where(level: params[:level]) if params[:level].present?
      @scholarships = @scholarships.where(field_of_study: params[:field_of_study]) if params[:field_of_study].present?

    else

      @scholarships = @recent_scholarships
    end

    @countries = Scholarship.published.distinct.pluck(:country).compact.sort
    @levels = Scholarship.published.distinct.pluck(:level).compact.sort
    @fields_of_study = Scholarship.published.distinct.pluck(:field_of_study).compact.sort
  end
end
