require 'pp'
require 'os'
require 'securerandom'

module ProblemsHelper
  
  def eval_code(code, problemID, timeout=4)
    @compile_languages = ['java']
    #@file_names also append SecureRandom.hex to prevent accidental collisions. Excluding only python.
    @file_names = {python: 'student_code', folder: 'temp_', input: 'input_', expected_output: 'expected_', actual_output: 'output_'}
    
    begin 
      rand_folder_name = @file_names[:folder] + SecureRandom.hex(8) 
    end while Dir.exist?(rand_folder_name)
    FileUtils.mkdir(rand_folder_name)
    problem = Problem.find(problemID)
    begin
      case problem.language
      when 'java'
        unsafe, message = io_imported?(code)
        return {:status => 'error', :err => message} if unsafe
        
        name = determine_java_file_name(code)
        if name == nil
          return {:status => 'error', :err => 'no main method detected'}
        end
        file = rand_folder_name + '/' + name + '.java'
      when 'python'
        file = rand_folder_name + '/' + @file_names[:python] + '.py'
      else
        clean_files(rand_folder_name)
        return {:status => 'error', :err => 'problem has to language set'}
      end
      File.open(file, 'w') do |f|
        f.print code
      end
      
      if @compile_languages.include?(problem.language)
        my_json = compile_problem(code, problem, rand_folder_name)
      else
        my_json = {}
        my_json[:status] = 'success'
        my_json[:err] = ''
      end
      
      if my_json[:status] == 'success'
        my_json[:results] = execute_problem(code, problem, rand_folder_name, timeout)
      end
    rescue => e
      my_json = {:status => 'error', :err => "Unknown Error in Ruby on Rails has occured. Running Code Suspended. Error: #{e}", :results => []}
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
  
  def io_imported?(code)
    if /java\s*\.\s*io/.match(code)
      return true, 'Autograder restricts use of term java.io.'
    elsif /java\s*\.\s*\*/.match(code)
      return true, 'Autograder restricts use of term java.*.'
    else
      return false, ''
    end
  end
  
  def files_equal?(file1, file2)
    f1 = File.open(file1)
    f2 = File.open(file2)
    s1 = f1.read(f1.size).strip
    s2 = f2.read(f2.size).strip
    s1.eql?(s2)
  end
  
  def get_os_command(timeout, folder, command)
    if OS.windows?
      if timeout == -1
        return 'cmd /c \"cd ' + folder + ' && ' + command + '\"'
      else
        return 'cmd /c \"cd ' + folder + ' && ' + command + '\"'
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
      my_json[:err] = compileError
    else
      my_json[:status] = 'fail'
      my_json[:err] = compileError
    end
    return my_json
  end
  
  def execute_problem(code, problem, folder, timeout)
    my_append = SecureRandom.hex(6)
    
    case problem.language
    when 'java'
      name = determine_java_file_name(code)
      command = get_os_command(timeout, folder, 'java ' + name + ' < ' + @file_names[:input] + my_append + '.txt > ' + @file_names[:actual_output] + my_append + '.txt')
    when 'python'
      command = get_os_command(timeout, folder, 'python ' + @file_names[:python] + '.py < ' + @file_names[:input] + my_append + '.txt > ' + @file_names[:actual_output] + my_append + '.txt')
    end
    
    results_array = []  
    ProblemTestCase.where(problemid: problem.id).each do |testcase|
      File.open(folder + '/' + @file_names[:input] + my_append + '.txt', 'w') do |f|
        f.print testcase.input
      end
      File.open(folder + '/' + @file_names[:expected_output] + my_append + '.txt', 'w') do |f|
        f.print testcase.output
      end
      
      runtimeOut, runtimeError, runtimeStatus = Open3.capture3(command)
      
      result_hash = {}
      result_hash[:title] = testcase.title
      result_hash[:input] = testcase.input   
      if runtimeStatus.success? && File.exists?(folder + '/' + @file_names[:actual_output] + my_append + '.txt') 
        if files_equal?(folder + '/' + @file_names[:expected_output] + my_append + '.txt', folder + '/' + @file_names[:actual_output] + my_append + '.txt') 
          result_hash[:result] = 'success'
        else
          result_hash[:result] = 'fail'
        end
        result_hash[:output] = File.read(folder + '/' + @file_names[:actual_output] + my_append + '.txt');
        result_hash[:err] = runtimeError
      elsif runtimeStatus.exitstatus == 124
        result_hash[:result] = 'fail'
        result_hash[:err] = 'Program timed out by Autograder for taking too long. (5+ seconds)'
        result_hash[:output] = ''
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
