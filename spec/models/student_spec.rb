require 'rails_helper'

describe Student do
  before :each do
    @department = Department.create(department_name: 'Electronics')
    @student = Student.new(
      name: 'Shubhangi Taklikar',
      department_id: @department.id
    )
  end

  it 'is valid with all valid parameters' do
    expect(@student).to be_valid
  end

  it 'is invalid without name' do
    @student.name = nil
    @student.valid?
    expect(@student.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without department_id' do
    @student.department_id = nil
    @student.valid?
    expect(@student.errors[:department_id]).to include("can't be blank")
  end

  it 'is invalid with duplicate student' do
    @student.save
    student2 = Student.new(
      name: 'Shubhangi Taklikar',
      department_id: @department.id
    )
    student2.valid?
    expect(student2.errors[:name]).to include('has already been taken')
  end
end
