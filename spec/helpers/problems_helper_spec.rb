require 'rails_helper'
require 'open3'

describe ProblemsHelper, :type => :helper do
  before :all do
    Problem.create!(title:'IO Java', language:'java')
    ProblemTestCase.create!(problemid:1, input:'testingbecauseican', output:'testingbecauseican')
    Problem.create!(title:'IO Python', language:'python')
    ProblemTestCase.create!(problemid:2, input:'testingbecauseican', output:'testingbecauseican')
  end
  
  describe "Running with java code" do
    it 'should succeed with good code' do
      code = "import java.io.*;\n"+
            "public class useCode {\n"+
            " public static void main(String args[]) throws IOException{\n"+
            "   FileInputStream in = null;\n"+
            "   FileOutputStream out = null;\n"+
            "   try {\n"+
            "     in = new FileInputStream(\"input.txt\");\n"+
            "     out = new FileOutputStream(\"output.txt\");\n"+
            "     int c;\n"+
            "     while ((c = in.read()) != -1) {\n"+
            "       out.write(c);\n"+
            "     }\n"+
            "   }\n"+
            "   finally {\n"+
            "     if (in != null) {in.close();}\n"+
            "     if (out != null) {out.close();}\n"+
            "   }\n"+
            "  }\n"+
            "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('success')
      expect(result[:results][0][:err]).to eq(nil)
    end
    
    it 'should fail compile with bad java code' do
      code = "import java.io.*;\n"+
            "public class useCode {\n"+
            " public static void main(String args[]) throws IOException{\n"+
            "   FileInputStream in = null;\n"+
            "   FileOutputStream out = null;\n"+
            "   try {\n"+
            "     in = new FileInputStream(\"input.txt\")\n"+
            "     int c;\n"+
            "     while ((c = in.read()) != -1) {\n"+
            "       out.write(c);\n"+
            "     }\n"+
            "   }\n"+
            "   finally {\n"+
            "     if (in != null) {in.close();}\n"+
            "     if (out != null) {out.close();}\n"+
            "   }\n"+
            "  }\n"+
            "}"
        
      result = eval_code(code, 1)
      expect(result[:status]).to eq('fail')
      expect(result[:err]).to_not eq('')
      expect(result[:results]).to eq([])
    end
    
    it 'should pass compile and fail testcase with good, but wrong, java code' do
      code = "import java.io.*;\n"+
            "public class useCode {\n"+
            " public static void main(String args[]) throws IOException{\n"+
            "   FileInputStream in = null;\n"+
            "   FileOutputStream out = null;\n"+
            "   try {\n"+
            "     in = new FileInputStream(\"input.txt\");\n"+
            "     out = new FileOutputStream(\"output.txt\");\n"+
            "     int c;\n"+
            "     while ((c = in.read()) != -1) {\n"+
            "       out.write(c);\n"+
            "       out.write(1);\n"+
            "     }\n"+
            "   }\n"+
            "   finally {\n"+
            "     if (in != null) {in.close();}\n"+
            "     if (out != null) {out.close();}\n"+
            "   }\n"+
            "  }\n"+
            "}"
      result = eval_code(code, 1)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to eq(nil)
    end
    
    it 'should succeed with good python code' do
      code ="with open('output.txt', 'w') as f1:\n"+
            "  for line in open('input.txt'):\n"+
            "    f1.write(line)"
            
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('success')
      expect(result[:results][0][:err]).to eq(nil)
    end
    
    it 'should fail compile with bad python code' do
      code ="with open('output.txt', 'w') as f1:\n"+
            "  for line in open('input.txt'):\n"+
            "f1.write(line)"
        
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to_not eq(nil)
    end
    
    it 'should pass compile and fail testcase with good, but wrong, python code' do
      code ="with open('output.txt', 'w') as f1:\n"+
            "  for line in open('input.txt'):\n"+
            "    f1.write(line)\n"+
            "    f1.write('extra')\n"
            
      result = eval_code(code, 2)
      expect(result[:status]).to eq('success')
      expect(result[:err]).to eq('')
      expect(result[:results][0][:result]).to eq('fail')
      expect(result[:results][0][:err]).to eq(nil)
    end
  end
end
