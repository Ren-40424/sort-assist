class Api::CoursesController < ApplicationController
  def index
    @courses = Course.where(sheet_id: params[:sheet_id]).includes(:addresses)
    render json: @courses.as_json(include: :addresses)
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :explanation, :create_load_sheet, :sheet_id)
  end
end
