class ScholarshipsController < ApplicationController
    def index
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
