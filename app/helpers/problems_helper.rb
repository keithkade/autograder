module ProblemsHelper
  def eval_code(code, problemID, studentID)
    open('useCode.java', 'w') do |f|
      f.puts code
    end
      
    
    problem = Problem.find(problemID)
    case problem.language
    when 'java'
      return eval_java_code(code)
    end 
    return nil
  end
    
  private
  def clean_files
    File.delete('input.java') if File.exist?('input.java')
    File.delete('expected.class') if File.exist?('expected.class')
    File.delete('output.java') if File.exist?('output.java')
    File.delete('useCode.java') if File.exist?('useCode.java')
    File.delete('useCode.class') if File.exist?('useCode.class')
  end
  
  def check_correctness(runtimeOut)
    # TODO Figure out what to do about system.out or file
    if File.exist?('output.txt')
      return FileUtils.compare_file('expected.txt', 'output.txt')
    else
      file = File.open('expected.txt')
      text = file.read
      return runtimeOut == text
    end
  end

  def eval_java_problem(code, problem)
    my_json = {}
    compileOut, compileError, compileStatus = Open3.capture3("java useCode")     
    
    if(not compileStatus.success?) 
      my_json[:status] = 'fail'
      my_json[:err] = compileError
      my_json[:results] = []
    else
      my_json[:status] = 'success'
      my_json[:err] = ''
      results_array = []
      ProblemTestCase.where(problemid: problem.id).each do |testcase|
        result_hash = {}
        result_hash[:title] = 'temp_title'
        result_hash[:input] = testcase.input
        
        runtimeOut, runtimeError, runtimeStatus = run_java_testcase(testcase.input, testcase.output)
        if(not runtimeStatus.success?) 
          result_hash[:result] = 'fail'
          result_hash[:err] = runtimeError
        else
          check_correctness ? result_hash[:result] = 'success' : result_hash[:result] = 'fail'
        end
      end
      my_json[:results] = results_array
    end
  end
  
  def run_java_testcase(input, expected)
    open('input.txt', 'w') do |f|
      f.puts input
    end
        
    open('expected.txt', 'w') do |f|
      f.puts expected
    end
    
    runtimeOut, runtimeError, runtimeStatus = Open3.capture3("java useCode")     
    return runtimeOut, runtimeError, runtimeStatus
  end
    
  def eval_ruby_case(code)
    return nil,nil
  end
end
