require 'rails_helper'

describe StudentsController do

	before :each do
		@department = Department.create(department_name: "Electronics")
	end
	
	describe 'GET index' do

		it "populates an array of students and renders index view" do
			student = Student.create(
					name: "Shubhangi Taklikar",
					department_id: @department.id
				)
			get :index
			expect(assigns(:students)).to eq([student])
			expect(response).to render_template("index")
		end
	end

	describe 'GET show' do

		it "assigns the requested student to @student and renders show view" do
			student = Student.create(
					name: "Shubhangi Taklikar",
					department_id: @department.id
				)
			get :show, params: {id: student.id}
			expect(assigns(:student)).to eq(student)
			expect(response).to render_template("show")
		end
	end

	describe 'POST create' do

		before :each do
			@student = Student.new(	
					name: "Shubhangi Taklikar",
					department_id: @department.id
				)
		end

		context "with valid attributes" do 
			it "creates new student and redirects to created student" do
				expect{
					post :create, params: {student: @student.attributes}
				}.to change(Student, :count).by(1)
				expect(response).to redirect_to(Student.last)
			end
		end

		context "with name not present" do
			it "does not save student and renders new view" do
				@student.name = nil
				expect{
					post :create, params: {student: @student.attributes}
				}.to_not change(Student, :count)
				expect(response).to render_template("new")
			end
		end

		context "with department_id not present" do
			it  "does not save student and renders new view" do
				@student.department_id = nil
				expect{
					post :create, params: {student: @student.attributes}
				}.to_not change(Student, :count)
				expect(response).to render_template("new")
			end
		end
	end

	describe 'PUT update' do

		before :each do
			@student = Student.create(	
					name: "Shubhangi Taklikar",
					department_id: @department.id
				)
			@department2  = Department.create(department_name: "Civil Engg")
			@student_params = {name: "Chetana Taklikar", department_id: @department2.id}
		end

		context "with valid attributes" do
			it "updates the student details and redirect to show view" do
				put :update, params: {id: @student.id, student: @student_params}
				expect(assigns(:student)).to eq(@student)
				@student.reload
				expect(@student.name).to eq(@student_params[:name])
				expect(@student.department_id).to eq(@student_params[:department_id])
				expect(response).to redirect_to student_path(@student)
			end
		end

		context "with name not present" do
			it "does not update student details and renders edit view" do
				put :update, params: {id: @student.id, student: @student_params.merge(name: nil)}
				expect(assigns(:student)).to eq(@student)
				@student.reload
				expect(@student.name).to_not eq(nil)
				expect(response).to render_template("edit")
			end
		end

		context "with department_id not present" do
			it "does not update student details and renders edit view" do
				put :update, params: {id: @student.id, student: @student_params.merge(department_id: nil)}
				expect(assigns(:student)).to eq(@student)
				@student.reload
				expect(@student.department_id).to_not eq(nil)
				expect(response).to render_template("edit")
			end
		end
	end
=begin
	describe 'DELETE destroy' do
		student = Student.create(
				name: "Shubhangi Taklikar",
				department_id: @department.id
			)
		it "deletes the student" do 
			expect{
				delete :destroy, params: {id: student.id}
			}.to change(Student, :count).by(-1)
			expect(response).to redirect_to students_path
		end
	end
=end
end