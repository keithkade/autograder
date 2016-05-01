class UpdateQuizMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    remove_column :quiz_multiple_choice_questions, :answers
    change_column :quiz_multiple_choice_questions, :correct_answer, :string
    add_column :quiz_multiple_choice_questions, :answer_A, :string
    add_column :quiz_multiple_choice_questions, :answer_B, :string
    add_column :quiz_multiple_choice_questions, :answer_C, :string
    add_column :quiz_multiple_choice_questions, :answer_D, :string
    add_column :quiz_multiple_choice_questions, :answer_E, :string
  end
end
