class Api::CoursesController < ApplicationController
  def index
    @courses = Course.where(sheet_id: params[:sheet_id])
    render json: @courses
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course
    else
      render json: @course.errors
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :explanation, :create_load_sheet, :sheet_id)
  end
end
