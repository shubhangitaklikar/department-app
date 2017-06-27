require 'rails_helper'

describe Department do
  before :each do
    @department = Department.new(
      department_name: 'Electronics'
    )
  end

  it 'is valid with department_name' do
    expect(@department).to be_valid
  end

  it 'is invalid without department_name' do
    @department.department_name = nil
    @department.valid?
    expect(@department.errors[:department_name]).to include("can't be blank")
  end

  it 'is invalid with dupicate department_name' do
    @department.save
    @department2 = Department.new(
      department_name: 'Electronics'
    )
    @department2.valid?
    expect(@department2.errors[:department_name]).to include('has already been taken')
  end

  # it "is invalid if department_name exceeds 10 character" do
  #     @department.department_name = "Electronics Engineering"
  #     @department.valid?
  #     expect(@department.errors[:department_name]).to include("is too long (maximum is 15 characters)")
  #   end
end
