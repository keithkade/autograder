# 431Project

We have the best project.

WE ARE USING RUBY VERSION: 2.2.3

response encoding

```
{
  status: "success/fail"
  err: "compile error: yadadada"
  results : [
    {
      title: "test case #0",
      result: "success/fail",,
      err: "runtimeError: yadadada",
      input: "test case input 0"
    },
    {
      title: "test case #1",
      result: "success/fail",
      err: "runtimeError: yadadada",
      input: "test case input 1"
    },
    ...
  ]
}
```


Answer to Seed Problems 

IO Practice Java
```
import java.io.*;
public class useCode {
  public static void main(String args[]) throws IOException{
    FileInputStream in = null;
    FileOutputStream out = null;
    try {
      in = new FileInputStream("input.txt");
      out = new FileOutputStream("output.txt");
      int c;
      while ((c = in.read()) != -1) {
        out.write(c);
      }
    }
    finally {
      if (in != null) {in.close();}
      if (out != null) {out.close();}
    }
  }
}
```

IO Practice Python
```
with open('output.txt', 'a') as f1:
  for line in open('input.txt'):
    f1.write(line)
```

