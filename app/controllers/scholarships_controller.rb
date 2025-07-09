class ScholarshipsController < ApplicationController
    def index
        @countries = Scholarship.published.distinct.pluck(:country).compact.sort
        @levels = Scholarship.published.distinct.pluck(:level).compact.sort
        @fields_of_study = Scholarship.published.distinct.pluck(:field_of_study).compact.sort
        if params[:query].present?
            @scholarships = Scholarship.search_by_keywords(params[:query])
        else
            @scholarships = Scholarship.all
        end
    end

    def show
       @scholarship=Scholarship.find(params[:id])
    end
    
end
