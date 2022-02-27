import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('file.txt');
  
  Stream<String> lines = file.openRead()
    .transform(utf8.decoder) // Decodificar bytes para UTF-8.
    .transform(LineSplitter()); // Converta o fluxo em linhas individuais.

  try {
    await for (var line in lines) {
      print('$line: ${line.length} characters');
    }
    print('File is now closed.');
  } catch (e) {
    print('Error: $e');
  }
}