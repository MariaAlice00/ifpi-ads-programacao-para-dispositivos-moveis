import 'dart:convert';
import 'dart:io';

void main() async {
  var file = File(Platform.script.toFilePath());
  print(await (file.readAsString(encoding: ascii)));
}
