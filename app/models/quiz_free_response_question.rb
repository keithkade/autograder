class QuizFreeResponseQuestion < ActiveRecord::Base
  def automatic?
    false
  end
end
