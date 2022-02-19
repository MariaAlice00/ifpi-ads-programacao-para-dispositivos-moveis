void main() {
  String nome = 'Alice';
  String sobrenome = 'Lima';

  nomeCompleto(null);
}

String nomeCompleto(String nome, String sobrenome) {
  return nome + ' ' + sobrenome;
}