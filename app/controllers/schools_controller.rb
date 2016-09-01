class SchoolsController < ApplicationController
  before_action :school, except: [:index, :new, :create]
  
  def index
    @schools = School.all
  end

  def show
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
  	@school = School.new(school_params)
  	if @school.save
  		redirect_to school_path(@school), success: 'School has been created!'
  	else
  		render :new
  	end
  end

  def update
    if @school.update(school_params)
  		redirect_to school_path(@school), success: 'School has been updated!'
  	else
  		render :edit
  	end
  end

  def destroy
    @school.destroy
  	redirect_to schools_path, success: 'School has been deleted!'
  end

  private

  def school_params
    params.require(:school).permit(:name, :type)
  end

  def school
    @school = School.find(params[:id])
  end
end
