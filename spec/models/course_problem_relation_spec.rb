require 'spec_helper'


describe CourseProblemRelation do

	before :all do
		Course.create!(name: 'csce111')
		Problem.create!(title: 'IO Java', language: 'java')
	end

  describe 'relate!' do
    it 'should create the rlation row of courses and problems' do
    	relation = CourseProblemRelation.relate!(1, 1)
    	assert_equal(relation.course,1,"not course id")
    	assert_equal(relation.problem,1,"not problem id")
    end
  end


  describe 'destroy_by_problem' do
 	it 'should delete a relation when given a problem id' do
    	relation = CourseProblemRelation.relate!(1,1)
    	CourseProblemRelation.destroy_by_problem(1)
    	assert_equal(relation,nil,"not  = nil")
  	end
  end


  describe 'destroy_by_course' do
  	it 'should delete a relation when given a course id' do
    	relation = CourseProblemRelation.relate!(1,1)
    	CourseProblemRelation.destroy_by_course(1)
    	assert_equal(relation,nil,"not  = nil")
  	end
  end
end