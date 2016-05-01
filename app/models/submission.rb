class Submission < ActiveRecord::Base
    def total_cases
        Array(results_obj['results']).count
    end
    
    def success_cases
        Array(results_obj['results']).count { |item| item['result'] == "success" }
    end
    
    def results_obj
        JSON.parse(self.result)
    end
    
    def problem
        Problem.find_by_id(self.problem_id)
    end
end
