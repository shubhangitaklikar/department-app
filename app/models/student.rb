class Student < ApplicationRecord
	validates_presence_of :name, :department_id
	validates_uniqueness_of :name, scope: :department_id

	belongs_to :department
end
