require 'spec_helper'


describe CourseUserRelation do

	before :all do
		Course.create!(name: 'csce111')
		Student.create!(Name: 'tim')
	end


	describe 'relate!' do
		it 'should create the rlation row of courses and students' do
			relation = CourseUserRelation.relate!(1, 1)
			assert_equal(relation.course,1,"not course id")
			assert_equal(relation.problem,1,"not student id")
		end
	end



	describe 'destroy_by_problem' do
		it 'should delete a relation when given a user id' do
			relation = CourseUserRelation.relate!(1, 1)
			CourseUserRelation.destroy_by_user(1)
			assert_equal(relation,nil,"not  = nil")
		end
	end

	describe 'destroy_by_course' do
		it 'should delete a relation when given a course id' do
			relation = CourseUserRelation.relate!(1, 1)
			CourseUserRelation.destroy_by_course(1)
			assert_equal(relation,nil,"not = nil")
		end
	end

end