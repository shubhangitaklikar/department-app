require 'rails_helper'

describe DepartmentsController do
	
	describe 'GET index' do

		it "populates an array of departments and render index view" do
			department = Department.create(
					department_name: "Electronics"
				)
			get :index
			expect(assigns(:departments)).to eq([department])
			expect(response).to render_template("index")
		end
	end

	describe 'GET show' do

		it "assigns the requested department to @department and render show view" do
			department = Department.create(
					department_name: "Electronics"
				)
			get :show, params: {id: department.id}
			expect(assigns(:department)).to eq(department)
			expect(response).to render_template("show")

		end
	end

	describe 'POST create' do

		context "with valid attributes" do

			department = Department.new( department_name: "Electronics")

			it "creates new department and redirect to created department" do
				expect{
					post :create, params: {department: department.attributes}
				}.to change(Department, :count).by(1)
				expect(response).to redirect_to Department.last
			end
		end

		context "with invalid attributes" do

			department = Department.new( department_name: nil)

			it "does not save new department and render new" do
				expect{
					post :create, params: {department: department.attributes}
				}.to_not change(Department, :count)
				expect(response).to render_template("new")
			end
		end
	end

	describe 'PUT update' do

		before :each do
			@department = Department.create(department_name: "Electronics")
			@department_params = { department_name: "Civil Engg"} 
		end

		context "with valid attributes" do
			it "updates the department and redirect to updated department" do
				put :update, params: {id: @department, department: @department_params}
				expect(assigns(:department)).to eq(@department)
				@department.reload
				expect(@department.department_name).to eq("Civil Engg")
				expect(response).to redirect_to department_path(@department)
			end
		end

		context "with department_name is invalid" do

			it "does not update department and renders edit view" do
				put :update, params: {id: @department, department: @department_params.merge(department_name: nil)}
				expect(assigns(:department)).to eq(@department)
				@department.reload
				expect(@department.department_name).to_not eq("Civil Engg")
				expect(response).to render_template("edit")
			end
		end
	end

	describe 'DELETE destroy' do

		it "deletes the department and redirect to departments list" do
			department = Department.create(department_name: "Electronics")
			expect{
				delete :destroy, params: {id: department}
			}.to change(Department, :count).by(-1)
			expect(response).to redirect_to departments_path
		end
	end
end