require 'spec_helper'

describe Student do

	before :all do
		Course.create!(name: 'csce111', id: 100)
		Problem.create!(title: 'sort', language: 'java', due_date: DateTime.parse("1 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 100)
		Student.create!(FirstName: 'dillon', LastName: 'dishman', is_archived: false, password: 'bob', ID: SecureRandom.hex, id: 100)
		Submission.create!(student_id: 100, problem_id: 100, complete: true, time_submitted: DateTime.parse("1 May 2016 6:59:59 PM Central Time (US & Canada) "), id: 100, result: '{"status":"success","err":"","results":[{"title":"main case","input":"testingbecauseican","result":"success","output":"testingbecauseican\n","err":""}]}')
		Submission.create!(student_id: 100, problem_id: 102, complete: true, time_submitted: DateTime.parse("10 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 101, result: '{"status":"success","err":"","results":[{"title":"main case","input":"testingbecauseican","result":"success","output":"testingbecauseican\n","err":""}]}')
		Submission.create!(student_id: 100, problem_id: 102, complete: false, time_submitted: DateTime.parse("1 May 2016 6:59:59 PM Central Time (US & Canada) "), id: 102, result: '{"status":"success","err":"","results":[{"title":"main case","input":"testingbecauseican","result":"success","output":"testingbecauseican\n","err":""}]}')
		Submission.create!(student_id: 100, problem_id: 100, complete: false, time_submitted: DateTime.parse("10 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 103, result: '{"status":"success","err":"","results":[{"title":"main case","input":"testingbecauseican","result":"success","output":"testingbecauseican\n","err":""}]}')
		CourseUserRelation.relate!(100,100)
		CourseProblemRelation.relate!(100,100)

		Problem.create!(title: 'sort', language: 'java', due_date: DateTime.parse("20 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 101)
		Problem.create!(title: 'sort', language: 'java', due_date: DateTime.parse("1 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 102)
		Problem.create!(title: 'sort', language: 'java', due_date: DateTime.parse("1 May 2016 10:59:59 PM Central Time (US & Canada) "), id: 103)
		CourseProblemRelation.relate!(100,101)
		CourseProblemRelation.relate!(100,102)
		CourseProblemRelation.relate!(100,103)

	end

	after :all do 
		Student.delete(100)
		Course.delete(100)
		Problem.delete(100)
		Problem.delete(101)
		Problem.delete(102)
		Problem.delete(103)
		Submission.delete(100)
		Submission.delete(101)
		Submission.delete(102)
		Submission.delete(103)
	end

	describe 'problems_grade' do
		it 'should save Problems_grade as 0/0' do
			student = Student.find(100)
			student.problems_grade
			expect(student.problems_grade).to eql(true)
		end
	end

	describe 'incomplete_problems_past_due' do
		it 'should return the number of problems that are incomplete and past due' do
			student = Student.find(100)
			expect(student.incomplete_problems_past_due.count).to eql(0)
		end
	end

	describe 'quizs_grade' do
		it 'should return the quize grade as a percent' do
			student = Student.find(100)
			expect(student.quizs_grade).to eql(true)
		end
	end

	describe 'active_quizzes' do
		it 'should active_quizzes' do
			student = Student.find(100)
			expect(student.active_quizzes.count).to eql(0)
		end
	end

	describe 'quiz_submissions' do
		it 'should quiz_submissions' do
			student = Student.find(100)
			expect(student.quiz_submissions.count).to eql(0)
		end
	end

	describe 'problems' do
		it 'should problems' do
			student = Student.find(100)
			expect(student.problems.count).to eql(1)
		end
	end

	describe 'submissions' do
		it 'should submissions' do
			student = Student.find(100)
			expect(student.submissions.count).to eql(4)
		end
	end
end

