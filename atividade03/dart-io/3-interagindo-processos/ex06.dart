import 'dart:io';

void main() async {
  // Lista todos os arquivos no diretório atual, em sistemas operacionais do tipo UNIX.
  ProcessResult results = await Process.run('ls', ['-l']);
  print(results.stdout);
}
