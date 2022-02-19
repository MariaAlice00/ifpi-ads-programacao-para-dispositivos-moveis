void main() {
  var salarioAtual = 1200;

  var salarioAno1 = salarioAtual + (0.07 * salarioAtual);
  var salarioAno2 = salarioAno1 + (0.06 * salarioAno1);
  var salarioAno3 = salarioAno2 + (0.05 * salarioAno2);

  String salarioAno1String = salarioAno1.toStringAsFixed(2);
  String salarioAno2String = salarioAno2.toStringAsFixed(2);
  String salarioAno3String = salarioAno3.toStringAsFixed(2);

  print('Salário daqui 1 ano: R\$ $salarioAno1String');
  print('Salário daqui 2 anos: R\$ $salarioAno2String');
  print('Salário daqui 3 anos: R\$ $salarioAno3String');
}
