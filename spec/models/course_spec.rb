require 'spec_helper'

describe Course do
    describe 'problems' do
        it 'should return an array of associated problems' do
            @course = Course.create!(:name => "Course")
            @rel1 = CourseProblemRelation.create!(:course => 1, :problem => 1)
            @rel2 = CourseProblemRelation.create!(:course => 2, :problem => 2)
            @rel3 = CourseProblemRelation.create!(:course => 1, :problem => 3)
            @fake_prob1 = double('Problem')
            @fake_prob2 = double('Problem')
            Problem.stub(:where).with(:id => [1, 3]).and_return([@fake_prob1, @fake_prob2])
            @course.problems.should eq([@fake_prob1, @fake_prob2])
        end
    end
end