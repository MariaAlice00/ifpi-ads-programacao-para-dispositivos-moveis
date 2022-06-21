import 'dart:io';

String fixture(String advice) => File('test/fixtures/$advice').readAsStringSync();