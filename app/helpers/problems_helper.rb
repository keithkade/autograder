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
        name = determine_java_file_name(code)
        file = rand_folder_name + '/' + name + '.java'
      when 'python'
        file = rand_folder_name + '/useCode.py'
      else
        clean_files(rand_folder_name)
        return {:status => 'fail', :err => 'problem has to language set', :results => []}
      end
      File.open(file, 'w') do |f|
        f.print code
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
  
  def determine_java_file_name(code)
    if /public class ([A-Za-z][0-9A-Za-z_]+) {/.match(code)
      return /public class ([A-Za-z][0-9A-Za-z_]+) {/.match(code)[1]
    elsif /class ([A-Za-z][0-9A-Za-z_]+) {((?!class)[\s\S])+ public static (void|int) main\(/.match(code)
      return /class ([A-Za-z][0-9A-Za-z_]+) {((?!class)[\s\S])+ public static (void|int) main\(/.match(code)[1]
    else
      return nil
    end
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
      name = determine_java_file_name(code)
      command = get_os_command(-1, folder, 'javac ' + name + '.java')
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
    my_append = SecureRandom.hex(6)
    
    case problem.language
    when 'java'
      name = determine_java_file_name(code)
      command = get_os_command(10, folder, 'java ' + name + ' < input_' + my_append + '.txt > output_' + my_append + '.txt')
    when 'python'
      command = get_os_command(10, folder, 'python useCode.py < input_' + my_append + '.txt > output_' + my_append + '.txt')
    end
    
    results_array = []  
    ProblemTestCase.where(problemid: problem.id).each do |testcase|
      File.open(folder + '/input_' + my_append + '.txt', 'w') do |f|
        f.print testcase.input
      end
      File.open(folder + '/expected_' + my_append + '.txt', 'w') do |f|
        f.print testcase.output
      end
      
      runtimeOut, runtimeError, runtimeStatus = Open3.capture3(command)
      
      result_hash = {}
      result_hash[:title] = testcase.title
      result_hash[:input] = testcase.input   
      
      if(runtimeStatus.success? && File.exists?(folder + '/output_' + my_append + '.txt')) 
        FileUtils.compare_file(folder + '/expected_' + my_append + '.txt', folder + '/output_' + my_append + '.txt') ? result_hash[:result] = 'success' : result_hash[:result] = 'fail'
        result_hash[:output] = File.read(folder + '/output_' + my_append + '.txt');
      else
        result_hash[:result] = 'fail'
        result_hash[:err] = runtimeError
        result_hash[:output] = ''
      end
      results_array.push(result_hash)
    end
    return results_array
  end
end
