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

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      render json: { notice: 'コースを削除しました' }, status: :ok
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update_create_load_sheet
    @course = Course.find(params[:id])
    if @course.update(create_load_sheet_param)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :explanation, :create_load_sheet, :sheet_id)
  end

  def create_load_sheet_param
    params.require(:course).permit(:create_load_sheet)
  end
end
