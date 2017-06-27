class DepartmentsController < ApplicationController
  before_action :get_department, only: %i[show edit update destroy]

  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to department_path(@department)
    else
      render 'new'
    end
  end

  def show
    @students = @department.students
  end

  def edit; end

  def update
    if @department.update_attributes(department_params)
      redirect_to department_path(@department)
    else
      render 'edit'
    end
  end

  def destroy
    if @department
      @department.destroy
      redirect_to departments_path
    end
  end

  private

  def get_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:department_name)
  end
end
