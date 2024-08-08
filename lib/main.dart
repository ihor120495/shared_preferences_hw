import 'package:flutter/material.dart';
import 'shared_preferences_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SharedPreferences Example')),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<String> _stringList = [];

  @override
  void initState() {
    super.initState();
    _initializeList();
  }

  Future<void> _initializeList() async {
    // Збережемо список рядків
    await _prefsHelper.saveStringList(['Item 1', 'Item 2', 'Item 3']);

    // Видаляю певний рядок
    await _prefsHelper.removeStringFromList('Item 2');

    // Отримую оновлений список
    final updatedList = await _prefsHelper.getStringList();

    setState(() {
      _stringList = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: _stringList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_stringList[index]),
          );
        },
      ),
    );
  }
}


