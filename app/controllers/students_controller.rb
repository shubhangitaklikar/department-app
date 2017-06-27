class StudentsController < ApplicationController
  before_action :get_student, only: %i[show edit update destroy]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new(department_id: params[:department_id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to student_path(@student)
    else
      puts @student.errors.full_messages
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @student.update(student_params)
      redirect_to student_path(@student)
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path
  end

  private

  def get_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :department_id)
  end
end
