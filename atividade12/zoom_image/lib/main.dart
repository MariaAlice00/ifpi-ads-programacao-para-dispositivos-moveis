import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Zoom Image';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  double _currentSize = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _currentSize,
          max: 600,
          divisions: 5,
          label: _currentSize.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSize = value;
            });
          },
        ),
        Image.asset('images/paisagem.jpg', width: _currentSize,)
      ],
    );
  }
}
