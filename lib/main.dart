import 'package:barbarian/barbarian.dart';
import 'package:barbarianexample/barbarian/children.dart';
import 'package:barbarianexample/barbarian/person.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter & Barbarian Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Person _brian = Person()
    ..name = 'Pierre'
    ..last = 'Guillen';

  Children children = Children();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Barbarian.init();

      children.empty();
      children.addChild('Brian', 'Castillo');

      await Future.delayed(Duration(seconds: 4));

      _brian..name = 'Carlos';
      _brian.save();

      children.addChild('Carlos', 'Ramirez');

      await Future.delayed(Duration(seconds: 4));

      _brian..name = 'Frank';
      _brian.save();

      children.addChild('Frank', 'Moreno');

      await Future.delayed(Duration(seconds: 4));

      _brian..name = 'Pierre';
      _brian.save();

      children.addChild('Pierre', 'Guillen');

      await Future.delayed(Duration(seconds: 4));

      _brian..name = 'Alexis';
      _brian.save();

      children.addChild('Alexis', 'Uribe');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbarian'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Person>(
              valueListenable: _brian.listen(_brian),
              builder: (context, value, _) {
                print('person $value');
                return Text('Hi ${value?.name}');
              },
            ),
            ValueListenableBuilder(
              valueListenable: children.listen(),
              builder: (context, value, _) {
                print('children $value');
                return Text('Children ${value?.length ?? 0}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
