class AddQuestionidToQuizFreeResponseQuestion < ActiveRecord::Migration
  def change
    add_column :quiz_free_response_questions, :questionid, :integer
  end
end
