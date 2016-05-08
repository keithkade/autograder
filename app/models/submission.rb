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
    
    def time_spent
        minutes = (time_submitted.to_i - page_loaded_at.to_i) / 60
        seconds = (time_submitted.to_i - page_loaded_at.to_i) % 60
        extra_zero = seconds < 10 ? "0" : ""
        "#{minutes}:#{extra_zero}#{seconds}"
    end
end
