class Department < ApplicationRecord
  validates_presence_of :department_name
  validates_uniqueness_of :department_name
  # validates_length_of :department_name, {:maximum => 15}

  has_many :students
end
