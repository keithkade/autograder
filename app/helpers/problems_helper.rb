require 'pp'
require 'os'

module ProblemsHelper
  
  def eval_code(code, problemID)
    compile_languages = ['java']
    
    rand_folder_name = "temp_" + SecureRandom.hex
    FileUtils.mkdir(rand_folder_name)
    problem = Problem.find(problemID)
    
    begin
      case problem.language
      when 'java'
        file = rand_folder_name + '/useCode.java'
      when 'python'
        file = rand_folder_name + '/useCode.py'
      else
        clean_files(rand_folder_name)
        return {:status => 'fail', :err => 'problem has to language set', :results => []}
      end
      File.open(file, 'w') do |f|
        f.puts code
      end
      
      if compile_languages.include?(problem.language)
        my_json = compile_problem(code, problem, rand_folder_name)
      else
        my_json = {}
        my_json[:status] = 'success'
        my_json[:err] = ''
      end
      
      if my_json[:status] == 'success'
        my_json[:results] = execute_problem(code, problem, rand_folder_name)
      end
    ensure
      clean_files(rand_folder_name)
    end
    return my_json
  end
    
  private
  def clean_files(folder)
    FileUtils.remove_dir(folder) if File.directory?(folder)
  end
  
  def get_os_command(timeout, folder, command)
    if OS.windows?
      if timeout == -1
        return 'cmd /c \"cd ' + folder + ' && ' + command + '\"'
      else
        #difficult bat?
      end
    elsif OS.mac?
      if timeout == -1
        return '(cd ' + folder + ' ; ' + command + ')'
      else
        return '(cd ' + folder + ' ; gtimeout ' + timeout.to_s + ' ' + command + ')'
      end
    else 
      if timeout == -1
        return '(cd ' + folder + ' ; ' + command + ')'
      else
        return '(cd ' + folder + ' ; timeout ' + timeout.to_s + ' ' + command + ')'
      end
    end
  end

  def compile_problem(code, problem, folder)
    case problem.language
    when 'java'
      command = get_os_command(-1, folder, 'javac useCode.java')
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
  
  def execute_problem(code, problem, folder)
    case problem.language
    when 'java'
      command = get_os_command(10, folder, 'java useCode')
    when 'python'
      command = get_os_command(10, folder, 'python useCode.py')
    end
    
    results_array = []  
    ProblemTestCase.where(problemid: problem.id).each do |testcase|
      File.open(folder + '/input.txt', 'w') do |f|
        f.puts testcase.input
      end
      File.open(folder + '/expected.txt', 'w') do |f|
        f.puts testcase.output
      end
      
      runtimeOut, runtimeError, runtimeStatus = Open3.capture3(command)
      
      result_hash = {}
      result_hash[:title] = 'stuff'
      result_hash[:input] = testcase.input
      result_hash[:output] = runtimeOut   
      
      if(runtimeStatus.success? && File.exists?(folder + '/output.txt')) 
        FileUtils.compare_file(folder + '/expected.txt', folder + '/output.txt') ? result_hash[:result] = 'success' : result_hash[:result] = 'fail'
      else
        result_hash[:result] = 'fail'
        result_hash[:err] = runtimeError
      end
      results_array.push(result_hash)
    end
    return results_array
  end
end
