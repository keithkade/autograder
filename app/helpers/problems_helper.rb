module ProblemsHelper
  
  def eval_code(code, problemID)
    compile_languages = ['java']
  
    problem = Problem.find(problemID)
    
    case problem.language
    when 'java'
      command = 'useCode.java'
    when 'python'
      command = 'useCode.py'
    else
      return {:status => 'fail', :err => 'problem has to language set', :results => []}
    end
    File.open(command, 'w') do |f|
      f.puts code
    end
    
    if compile_languages.include?(problem.language)
      my_json = compile_problem(code, problem)
    else
      my_json = {}
      my_json[:status] = 'success'
      my_json[:err] = ''
    end
    
    if my_json[:status] == 'success'
      my_json[:results] = execute_problem(code, problem)
    end
    
    clean_files
    return my_json
  end
    
  private
  def clean_files
    File.delete('input.txt') if File.exist?('input.txt')
    File.delete('expected.txt') if File.exist?('expected.txt')
    File.delete('output.txt') if File.exist?('output.txt')
    File.delete('useCode.java') if File.exist?('useCode.java')
    File.delete('useCode.class') if File.exist?('useCode.class')
    File.delete('useCode.py') if File.exist?('useCode.py')
  end
  
  def compile_problem(code, problem)
    case problem.language
    when 'java'
      command = 'javac useCode.java'
    end
    
    compileOut, compileError, compileStatus = Open3.capture3(command) 
    my_json = {}
    if(compileStatus.success?)
      my_json[:status] = 'success'
      my_json[:err] = ''
    else
      my_json[:status] = 'fail'
      my_json[:err] = compileError
    end
    return my_json
  end
  
  def execute_problem(code, problem)
    case problem.language
    when 'java'
      command = 'java useCode'
    when 'python'
      command = 'python useCode.py'
    end
    
    results_array = []  
    ProblemTestCase.where(problemid: problem.id).each do |testcase|
      File.open('input.txt', 'w') do |f|
        f.puts testcase.input
      end
      File.open('expected.txt', 'w') do |f|
        f.puts testcase.output
      end
      
      runtimeOut, runtimeError, runtimeStatus = Open3.capture3(command)
      
      result_hash = {}
      result_hash[:title] = 'stuff'
      result_hash[:input] = testcase.input
      result_hash[:output] = runtimeOut   
      
      if(runtimeStatus.success?) 
        FileUtils.compare_file('expected.txt', 'output.txt') ? result_hash[:result] = 'success' : result_hash[:result] = 'fail'
      else
        result_hash[:result] = 'fail'
        result_hash[:err] = runtimeError
      end
      results_array.push(result_hash)
    end
    return results_array
  end
end
