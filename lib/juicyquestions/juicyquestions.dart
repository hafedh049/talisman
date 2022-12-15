class Question {
  String text;
  List<Option> choices;
  Option? selectedChoice;
  bool isLocked;
  Question({
    required this.text,
    required this.choices,
    this.isLocked = false,
    this.selectedChoice,
  });
}

class Option {
  final String text;
  final bool isCorrect;
  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final List<Question> matrixQuestions = <Question>[
  Question(
    text:
        r"""\begin{pmatrix} 1 & 2 & 3\\4 & 5 & 6\\7 & 8 & 9\end{pmatrix} \text{can have an inverse matrix ?}""",
    choices: [
      const Option(
        text: "True",
        isCorrect: true,
      ),
      const Option(
        text: "False",
        isCorrect: false,
      ),
    ],
  ),
];
final List<Question> electricityQuestions = <Question>[];
final List<Question> atomQuestions = <Question>[
  Question(
    text: "is Uranium a radioactif element?",
    choices: [
      const Option(
        text: "Correct",
        isCorrect: true,
      ),
      const Option(
        text: "Incorrect",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: "what is the first radio-actif element in the periodic table",
    choices: [
      const Option(
        text: "Bismuth",
        isCorrect: true,
      ),
      const Option(
        text: "Argon",
        isCorrect: false,
      ),
      const Option(
        text: "Gallium",
        isCorrect: false,
      ),
      const Option(
        text: "Krypton",
        isCorrect: false,
      ),
    ],
  ),
];
final List<Question> pythonQuestions = <Question>[
  Question(
    text: """What is the output of the following code?

def calculate (num1, num2=4):
  res = num1 * num2
  print(res)
calculate(5, 6)""",
    choices: const [
      Option(
        text: "20",
        isCorrect: false,
      ),
      Option(
        text: "the program executed with errors",
        isCorrect: false,
      ),
      Option(
        text: "30",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """The in operator is used to check if a value
exists within an iterable object container
such as a list. Evaluate to True if it 
finds a variable in the specified
sequence and False otherwise.""",
    choices: const [
      Option(
        text: "True",
        isCorrect: true,
      ),
      Option(
        text: "False",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

x = 36 / 4 * (3 +  2) * 4 + 2
print(x)""",
    choices: const [
      Option(
        text: "182.0",
        isCorrect: true,
      ),
      Option(
        text: "37",
        isCorrect: false,
      ),
      Option(
        text: "117",
        isCorrect: false,
      ),
      Option(
        text: "the program executed with errors",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

p, q, r = 10, 20 ,30
print(p, q, r)""",
    choices: const [
      Option(
        text: "10 20",
        isCorrect: false,
      ),
      Option(
        text: "10 20 30",
        isCorrect: true,
      ),
      Option(
        text: "Error: invalid syntax",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

salary = 8000

def printSalary():
    salary = 12000
    print("Salary:", salary)
      
printSalary()
print("Salary:", salary))""",
    choices: const [
      Option(
        text: "Salary: 12000 Salary: 8000",
        isCorrect: false,
      ),
      Option(
        text: "Salary: 8000 Salary: 12000",
        isCorrect: false,
      ),
      Option(
        text: "the program failed with errors",
        isCorrect: false,
      ),
      Option(
        text: """Salary: 12000
Salary: 8000""",
        isCorrect: true,
      ),
      Option(
        text: "none from above",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

listOne = [20, 40, 60, 80]
listTwo = [20, 40, 60, 80]

print(listOne == listTwo)
print(listOne is listTwo)""",
    choices: const [
      Option(
        text: """True
True""",
        isCorrect: false,
      ),
      Option(
        text: """True
False""",
        isCorrect: true,
      ),
      Option(
        text: """False
True""",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

str = "pynative"
print (str[1:3])""",
    choices: const [
      Option(
        text: "py",
        isCorrect: false,
      ),
      Option(
        text: "yn",
        isCorrect: true,
      ),
      Option(
        text: "pyn",
        isCorrect: false,
      ),
      Option(
        text: "yna",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

valueOne = 5 ** 2
valueTwo = 5 ** 3

print(valueOne)
print(valueTwo)""",
    choices: const [
      Option(
        text: """10
15""",
        isCorrect: false,
      ),
      Option(
        text: """25
125""",
        isCorrect: true,
      ),
      Option(
        text: "Error: invalid syntax",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

var = "James" * 2  * 3
print(var)""",
    choices: const [
      Option(
        text: "JamesJamesJamesJamesJamesJames",
        isCorrect: true,
      ),
      Option(
        text: "JamesJamesJamesJamesJames",
        isCorrect: false,
      ),
      Option(
        text: "Error: invalid syntax",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

var1 = 1
var2 = 2
var3 = "3"

print(var1 + var2 + var3)""",
    choices: const [
      Option(
        text: "6",
        isCorrect: false,
      ),
      Option(
        text: "33",
        isCorrect: false,
      ),
      Option(
        text: "123",
        isCorrect: false,
      ),
      Option(
        text: """"Error. Mixing operators between
numbers and strings are not supported""",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """A string is immutable in Python?

Every time when we modify the string,
Python Always create a new String and
assign a new string to that variable.""",
    choices: const [
      Option(
        text: "True",
        isCorrect: true,
      ),
      Option(
        text: "False",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the Output of the following code?

for x in range(0.5, 5.5, 0.5):
  print(x)""",
    choices: const [
      Option(
        text: "[0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5]",
        isCorrect: false,
      ),
      Option(
        text: "[0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]",
        isCorrect: false,
      ),
      Option(
        text: "the program executed with errors",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """Can we use the “else” block for for loop?

for example:

for i in range(1, 5):
    print(i)
else:
    print("this is else block statement" )""",
    choices: const [
      Option(
        text: "No",
        isCorrect: true,
      ),
      Option(
        text: "Yes",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """Which operator has higher precedence 
in the following list""",
    choices: const [
      Option(
        text: "% (Modulus)",
        isCorrect: false,
      ),
      Option(
        text: "& (BitWise AND)",
        isCorrect: false,
      ),
      Option(
        text: "** (Exponent)",
        isCorrect: true,
      ),
      Option(
        text: "> (Comparison)",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

sampleList = ["Jon", "Kelly", "Jessa"]
sampleList.append(2, "Scott")
print(sampleList)""",
    choices: const [
      Option(
        text: "the program executed with errors",
        isCorrect: true,
      ),
      Option(
        text: "[‘Jon’, ‘Kelly’, ‘Scott’, ‘Jessa’]",
        isCorrect: false,
      ),
      Option(
        text: "[‘Jon’, ‘Kelly’, ‘Jessa’, ‘Scott’]",
        isCorrect: false,
      ),
      Option(
        text: "[‘Jon’, ‘Scott’, ‘Kelly’, ‘Jessa’]",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """In Python 3, what is the output of
    type(range(5)).(What data type it will return).""",
    choices: const [
      Option(
        text: "int",
        isCorrect: false,
      ),
      Option(
        text: "list",
        isCorrect: false,
      ),
      Option(
        text: "range",
        isCorrect: true,
      ),
      Option(
        text: "None",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of print(type(10))""",
    choices: const [
      Option(
        text: "float",
        isCorrect: false,
      ),
      Option(
        text: "integer",
        isCorrect: false,
      ),
      Option(
        text: "int",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """Please select the correct expression to reassign
a global variable “x” to 20 inside a function fun1()

x = 50
def fun1():
    # your code to assign global x = 20
fun1()
print(x) # it should print 20""",
    choices: const [
      Option(
        text: "global x =20",
        isCorrect: false,
      ),
      Option(
        text: """global var x
x = 20""",
        isCorrect: false,
      ),
      Option(
        text: "global.x = 20",
        isCorrect: false,
      ),
      Option(
        text: """global x
x = 20""",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """What is the result of print(type([]) is list)""",
    choices: const [
      Option(
        text: "True",
        isCorrect: false,
      ),
      Option(
        text: "False",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

print(bool(0), bool(3.14159), bool(-3), bool(1.0+1j))""",
    choices: const [
      Option(
        text: "False True False True",
        isCorrect: false,
      ),
      Option(
        text: "True True False True",
        isCorrect: false,
      ),
      Option(
        text: "True True False True",
        isCorrect: false,
      ),
      Option(
        text: "False True True True",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """Select the right way to create
a string literal => Ault'Kelly""",
    choices: const [
      Option(
        text: "str1 = 'Ault\\\\'Kelly'",
        isCorrect: false,
      ),
      Option(
        text: "str1 = 'Ault\\'Kelly'",
        isCorrect: true,
      ),
      Option(
        text: 'str1 = """Ault`Kelly""" ',
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the data type of print(type(0xFF))""",
    choices: const [
      Option(
        text: "number",
        isCorrect: false,
      ),
      Option(
        text: "hexint",
        isCorrect: false,
      ),
      Option(
        text: 'hex',
        isCorrect: false,
      ),
      Option(
        text: 'int',
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?
    
aTuple = (1, 'Jhon', 1+3j)
print(type(aTuple[2:3]))""",
    choices: const [
      Option(
        text: "list",
        isCorrect: false,
      ),
      Option(
        text: "complex",
        isCorrect: false,
      ),
      Option(
        text: 'slice',
        isCorrect: false,
      ),
      Option(
        text: 'tuple',
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """What is the output of the 
following variable assignment?

x = 75
def myfunc():
    x = x + 1
    print(x)

myfunc()
print(x)""",
    choices: const [
      Option(
        text: "Error",
        isCorrect: true,
      ),
      Option(
        text: "76",
        isCorrect: false,
      ),
      Option(
        text: "1",
        isCorrect: false,
      ),
      Option(
        text: "None",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

def func1():
    x = 50
    return x
func1()
print(x)""",
    choices: const [
      Option(
        text: "NameError",
        isCorrect: true,
      ),
      Option(
        text: "50",
        isCorrect: false,
      ),
      Option(
        text: "0",
        isCorrect: false,
      ),
      Option(
        text: "None",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of print(type({}) is set)""",
    choices: const [
      Option(
        text: "True",
        isCorrect: false,
      ),
      Option(
        text: "False",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: """Select all the valid String creation in Python""",
    choices: const [
      Option(
        text: """str1 = 'str1'
str1 = "str1"
str1 = '''str'''""",
        isCorrect: true,
      ),
      Option(
        text: """str1 = 'str1'
str1 = "str1""
str1 = '''str1''""",
        isCorrect: false,
      ),
      Option(
        text: "str1 = str(Jessa)",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """which one is the correct options to copy a list

aList = ['a', 'b', 'c', 'd']""",
    choices: const [
      Option(
        text: "newList = copy(aList)",
        isCorrect: false,
      ),
      Option(
        text: "newList = aList.copy()",
        isCorrect: true,
      ),
      Option(
        text: "newList.copy(aList)",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: """What is the output of the following code?

aList = [1, 2, 3, 4, 5, 6, 7]
pow2 =  [2 * x for x in aList]
print(pow2)""",
    choices: const [
      Option(
        text: "[2, 4, 6, 8, 10, 12, 14]",
        isCorrect: true,
      ),
      Option(
        text: "[2, 4, 8, 16, 32, 64, 128]",
        isCorrect: false,
      ),
    ],
  ),
];
final List<Question> cQuestions = <Question>[
  Question(
    text: "is C considered a low level programming language ?",
    choices: [
      const Option(
        text: "true",
        isCorrect: false,
      ),
      const Option(
        text: "false",
        isCorrect: true,
      )
    ],
  ),
  Question(
    text: "C is strongly typed language",
    choices: [
      const Option(
        text: "Wrong",
        isCorrect: false,
      ),
      const Option(
        text: "Correct",
        isCorrect: true,
      )
    ],
  ),
  Question(
    text: "C supports OOP",
    choices: [
      const Option(
        text: "Yes",
        isCorrect: false,
      ),
      const Option(
        text: "No",
        isCorrect: true,
      )
    ],
  ),
  Question(
    text: "Choose the correct way to declare an integer variable",
    choices: [
      const Option(
        text: "a = 5",
        isCorrect: false,
      ),
      const Option(
        text: "integer a := 5;",
        isCorrect: false,
      ),
      const Option(
        text: "int a : 5;",
        isCorrect: false,
      ),
      const Option(
        text: "int a = 5;",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text: "is 'long long' a type in C?",
    choices: [
      const Option(
        text: "true",
        isCorrect: true,
      ),
      const Option(
        text: "false",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: "is C faster than Python in runtime?",
    choices: [
      const Option(
        text: "Correct",
        isCorrect: true,
      ),
      const Option(
        text: "Incorrect",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        """what is the value of a after executing the following code inside main function?
int a = 5;
++a
printf("%d",a++);
""",
    choices: [
      const Option(
        text: "6",
        isCorrect: false,
      ),
      const Option(
        text: "7",
        isCorrect: false,
      ),
      const Option(
        text: "runtime error",
        isCorrect: true,
      ),
    ],
  ),
];
final List<Question> integralQuestions = <Question>[
  Question(
    text: r"\int_{0}^{1} ln(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "-6.3",
        isCorrect: false,
      ),
      const Option(
        text: ".9",
        isCorrect: false,
      ),
      const Option(
        text: "undefined",
        isCorrect: false,
      ),
      const Option(
        text: "-1",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text:
        r"\text{Integration by parts, a method to find integral of a function, is also known as \text{\_\_\_\_\_\_}.}",
    choices: [
      const Option(
        text: "quotient rule",
        isCorrect: false,
      ),
      const Option(
        text: "reverse chain rule",
        isCorrect: false,
      ),
      const Option(
        text: "partial integration",
        isCorrect: false,
      ),
      const Option(
        text: "chain rule",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text:
        r"\text{The first 8 digits of this integral are the wifi password} \int_{-2}^{2} (x^3cos(\frac{x}{2}) + \frac{1}{2})\sqrt{4 - x^2}dx",
    choices: [
      const Option(
        text: "3.1415926",
        isCorrect: true,
      ),
      const Option(
        text: "1.6180339",
        isCorrect: false,
      ),
      const Option(
        text: "6.28318530",
        isCorrect: false,
      ),
      const Option(
        text: "2.7182818",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int tan(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"-\ln{cos x}  + c",
        isCorrect: false,
      ),
      const Option(
        text: r"-\ln{|cos x|}  + c",
        isCorrect: true,
      ),
      const Option(
        text: r"\log{|\frac{cos x}{x}|}  + c",
        isCorrect: false,
      ),
      const Option(
        text: r"ln(sin x) - x  + c",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int e^xdx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "e^x",
        isCorrect: false,
      ),
      const Option(
        text: "e^x  + c",
        isCorrect: true,
      ),
      const Option(
        text: "e^x - x",
        isCorrect: false,
      ),
      const Option(
        text: "xe^x",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int f'(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "f'(x)  + c",
        isCorrect: false,
      ),
      const Option(
        text: "f(x)",
        isCorrect: true,
      ),
      const Option(
        text: "f^{-1}(x)",
        isCorrect: false,
      ),
      const Option(
        text: "f''(x)",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int\frac{1}{x^n}dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{x^{n + 1}}{n + 1}",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{x^{1 - n}}{1 - n}  + c",
        isCorrect: true,
      ),
      const Option(
        text: r"\frac{1}{x^n + 1}",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{1}{x^n - 1}  + c",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int_{a}^{b} f(x) dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "F(b) - F(a)  + c",
        isCorrect: false,
      ),
      const Option(
        text: "F(a) - F(b)",
        isCorrect: false,
      ),
      const Option(
        text: "f(b) - f(a)",
        isCorrect: false,
      ),
      const Option(
        text: "F(b) - F(a)",
        isCorrect: true,
      ),
    ],
  ),
  Question(
    text:
        r"\int_{0}^{1} \sqrt{x + \sqrt{x + \sqrt{x + ...}}}dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "impossible!",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{5}{12}(1 + \sqrt{5})",
        isCorrect: true,
      ),
      const Option(
        text: r"0",
        isCorrect: false,
      ),
      const Option(
        text: r"-1",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"\lim_{n \to \infty} \sum_{i = 1}^{n} f(x_i)\Delta x \text{is known as \_\_\_\_\_\_ formula}",
    choices: [
      const Option(
        text: "Riemann",
        isCorrect: true,
      ),
      const Option(
        text: "Fibonacci",
        isCorrect: false,
      ),
      const Option(
        text: "Bertrand",
        isCorrect: false,
      ),
      const Option(
        text: "Euler",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"e = 2.71828... \text{ is called}",
    choices: [
      const Option(
        text: "Euler's Constant",
        isCorrect: true,
      ),
      const Option(
        text: "Golden Ratio",
        isCorrect: false,
      ),
      const Option(
        text: "Tau",
        isCorrect: false,
      ),
      const Option(
        text: "Graham's Number",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int (x^{dx} - 1)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"ln(x)",
        isCorrect: false,
      ),
      const Option(
        text: r"x\ln(x) - x  + c",
        isCorrect: true,
      ),
      const Option(
        text: "not defined!",
        isCorrect: false,
      ),
      const Option(
        text: r"1",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int_{0}^{1} (x^x)^{(x^x)^{(x^x)^{...}}}dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{\pi^2}{12}",
        isCorrect: true,
      ),
      const Option(
        text: r"-\frac{\pi}{6}",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"W_0(x) = \sum_{n = 1}^{\infty}\frac{(-n)^(n - 1)}{n!}x^n \text{ ?}",
    choices: [
      const Option(
        text: "True",
        isCorrect: true,
      ),
      const Option(
        text: "False",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"W_n (x)\text{ is know as \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "Lambert W Function",
        isCorrect: true,
      ),
      const Option(
        text: "Gamma Function",
        isCorrect: false,
      ),
      const Option(
        text: "Zeta Reimann Function",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"f^{-1}(W(x)) = xe^x \text{ ?}",
    choices: [
      const Option(
        text: "Correct",
        isCorrect: true,
      ),
      const Option(
        text: "Not Correct",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"\Gamma (x) = \int_{0}^{\infty} t^{x - 1}e^{-t} dt = (x - 1)! \text{ ?}",
    choices: [
      const Option(
        text: "Yes",
        isCorrect: true,
      ),
      const Option(
        text: "No",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"\zeta(s) = \sum_{n = 1}^{\infty}\frac{1}{n^s}\text{ is the \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "Zeta Reimann Summation",
        isCorrect: true,
      ),
      const Option(
        text: "Beta Function",
        isCorrect: false,
      ),
      const Option(
        text: "Maxwell Equation",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"Dirichlet-Eta\text{ function formula is \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\eta(s) = \sum_{n = 1}^{\infty}\frac{(-1)^{n - 1}}{n^s}",
        isCorrect: true,
      ),
      const Option(
        text: r"\eta(s) = \sum_{n = 1}^{\infty}\frac{-1^{n + 1}}{n^s}",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"\text{The Sophomore's Dream }\int_{0}^{1} x^{-x} dx\text{ is equal to \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\sum_{n = 1}^{\infty}n^{-n}",
        isCorrect: true,
      ),
      const Option(
        text: "undefined",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"Gabriel's\text{ Horn function is \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{1}{x}",
        isCorrect: true,
      ),
      const Option(
        text: r"\frac{1}{x^2}",
        isCorrect: false,
      ),
      const Option(
        text: r"-\frac{1}{x}",
        isCorrect: false,
      ),
      const Option(
        text: "x^x",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\pi \int_{a}^{b} [R(x)]^2dx\text{ is known as \_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "Gabriel's Horn Paradox",
        isCorrect: true,
      ),
      const Option(
        text: "Volume Of A Sphere",
        isCorrect: false,
      ),
      const Option(
        text: "Euler's Equation",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"2\pi \int_{1}^{\infty} \frac{1}{x}\sqrt{1 + [\frac{-1}{x^2}]^2}dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\pi",
        isCorrect: true,
      ),
      const Option(
        text: r"\infty",
        isCorrect: false,
      ),
      const Option(
        text: r"0",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\phi = \frac{a}{b} = \frac{a + b}{a}\text{ ? (assume that a > b)}",
    choices: [
      const Option(
        text: "True",
        isCorrect: true,
      ),
      const Option(
        text: "False",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text:
        r"\text{Golden Integral : }\int_{0}^{\infty} \frac{1}{(1 + x^{\phi})^{\phi}}dx = \text{\_\_\_\_\_\_  (assume that } \phi \text{ is the Golden Ratio} \approx \text{ 1.61803...)}",
    choices: [
      const Option(
        text: "1",
        isCorrect: true,
      ),
      const Option(
        text: r"\frac{1}{\phi}",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{1}{(\phi - 1)}",
        isCorrect: false,
      ),
      const Option(
        text: r"\phi - 1",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int_{0}^{1} \frac{ln(x + 1)}{x^2 + 1}dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{\pi \ln(2)}{8}",
        isCorrect: true,
      ),
      const Option(
        text: "1",
        isCorrect: false,
      ),
      const Option(
        text: r"\pi",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{1}{\pi}",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int |x| dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{x^2}{2} + c\text{ for x >= 0 else }-\frac{x^2}{2}  + c",
        isCorrect: true,
      ),
      const Option(
        text: "It cannot be integrated!",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int f^{-1}(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"xf^{-1}(x) - (F \circ f^{-1})(x)",
        isCorrect: true,
      ),
      const Option(
        text: "Depends on what function you are integrating",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int cos^2(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: r"\frac{1}{2}[x - \frac{sin(2x)}{2}]  + c",
        isCorrect: true,
      ),
      const Option(
        text: r"\frac{1}{2}[x - \frac{cos(x)}{2}]  + c",
        isCorrect: false,
      ),
      const Option(
        text: r"\frac{1}{2}[x - \frac{cos(2x)}{2}]  + c",
        isCorrect: false,
      ),
      const Option(
        text: r"-\frac{1}{2}[x - \frac{sin(x)}{2}]  + c",
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: r"\int arctan(x)dx = \text{\_\_\_\_\_\_}",
    choices: [
      const Option(
        text: "-6.3",
        isCorrect: false,
      ),
      const Option(
        text: r"x\arcsin(x)  + c",
        isCorrect: false,
      ),
      const Option(
        text: r"x\arctan(x) - \frac{1}{2}ln|1 + x^2|  + c",
        isCorrect: true,
      ),
    ],
  ),
];
