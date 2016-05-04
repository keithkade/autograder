require 'rails_helper'
require 'open3'

describe ProblemsHelper, :type => :helper do
  before :all do
    Problem.create!(title:'IO Java', language:'java')
    ProblemTestCase.create!(problemid:1, input:'testingbecauseican', output:'testingbecauseican')
    Problem.create!(title:'IO Python', language:'python')
    ProblemTestCase.create!(problemid:2, input:'testingbecauseican', output:'testingbecauseican')
    Problem.create!(title:'Bad Problem')
    ProblemTestCase.create!(problemid:3, input:'testingbecauseican', output:'testingbecauseican')
  end
  
  describe "Running with java code" do
    it 'should succeed with good code' do
      code = "import java.util.*;\n"+
              "public class useCode {\n"+
              "    public static void main(String args[]){\n"+
              "        Scanner in = new Scanner(System.in);\n"+
              "        while (in.hasNext()) {\n"+
              "            System.out.print(in.next());\n"+
              "        }\n"+
              "    }\n"+
              "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('success')
      expect(result[:results][0][:err]).to eq('')
    end
    
    it 'should fail compile with bad code' do
      code = "import java.util.*;\n"+
              "public class useCode {\n"+
              "    public static void main(String args[]){\n"+
              "        Scanner in = new Scanner(System.in);\n"+
              "        while (in.hasNext()) {\n"+
              "            System.out.print(in.next())\n"+
              "        }\n"+
              "    }\n"+
              "}"
        
      result = eval_code(code, 1)
      expect(result[:status]).to eq('fail')
      expect(result[:err]).to_not eq('')
      expect(result[:results]).to eq(nil)
    end
    
    it 'should pass compile and fail testcase with good, but wrong, code' do
      code = "import java.util.*;\n"+
              "public class useCode {\n"+
              "    public static void main(String args[]){\n"+
              "        Scanner in = new Scanner(System.in);\n"+
              "        while (in.hasNext()) {\n"+
              "            System.out.print(in.next() + \"a\");\n"+
              "        }\n"+
              "    }\n"+
              "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to eq('')
    end
    
    it 'should succeed with no public, but a main' do
      code ="import java.util.*;\n"+
              "class useCode {\n"+
              "    public static void main(String args[]){\n"+
              "        Scanner in = new Scanner(System.in);\n"+
              "        while (in.hasNext()) {\n"+
              "            System.out.print(in.next());\n"+
              "        }\n"+
              "    }\n"+
              "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('success')
      expect(result[:results][0][:err]).to eq('')
    end
    
    it 'should succeed with no public and no main' do
      code ="import java.util.*;\n"+
              "class useCode {\n"+
              "    public static void test(){\n"+
              "        Scanner in = new Scanner(System.in);\n"+
              "        while (in.hasNext()) {\n"+
              "            System.out.print(in.next());\n"+
              "        }\n"+
              "    }\n"+
              "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('error')
      expect(result[:err]).to_not eq('')
      expect(result[:results]).to eq(nil)
    end
  end
  
  describe "Running with python code" do
    it 'should succeed with good code' do
      code ="from __future__ import print_function\n"+
            "text = raw_input()\n"+
            "print(text)"
            
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('success')
      expect(result[:results][0][:err]).to eq('')
    end
    
    it 'should fail with bad code' do
      code ="from __future__ import print_function\n"+
            "text = rw_input()\n"+
            "print(text)"
        
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to_not eq('')
    end
    
    it 'should fail with good, but wrong, code' do
      code ="from __future__ import print_function\n"+
            "text = raw_input()\n"+
            "print(text + \"a\")"
            
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to eq('')
    end
  end
end
