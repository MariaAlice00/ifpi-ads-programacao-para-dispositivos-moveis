void main() {
  int? num1;
  int num2 = 10;

  if (num1 != null) {
    print(soma(num1, num2));
  } else {
    print('erro');
  }
}

int soma(int a, int b) {
  return a + b;
}
