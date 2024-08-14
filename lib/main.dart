import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerItem = TextEditingController();
  String savedText = '';
  List<String> listStrings = [];

  @override
  void initState() {
    loadString();
    loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Enter text'),
              ),
              const SizedBox(height: 40),
              Text(savedText),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  saveString(text: controller.text);
                  controller.clear();
                },
                child: const Text('Save String'),
              ),
              const SizedBox(
                height: 100,
              ),
              TextField(
                controller: controllerItem,
                decoration: const InputDecoration(labelText: 'Enter text'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  addItemToList(controllerItem.text);
                  controllerItem.clear();
                },
                child: const Text('Add string to list'),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: listStrings.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(3.0),
                        tileColor: Colors.cyanAccent,
                        title: Text(listStrings[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            removeItemFromList(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveString({required String text}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('SavedText', text);
    loadString();
  }

  void loadString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedText = prefs.getString('SavedText') ?? '';
    });
  }

  void saveList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listString', list);
    loadList();
  }

  void loadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listStrings = prefs.getStringList('listString') ?? [];
    });
  }

  void addItemToList(String index) {
    setState(() {
      listStrings.add(index);
    });

    saveList(listStrings);
  }

  void removeItemFromList(int index) {
    setState(() {
      listStrings.removeAt(index);
    });
    saveList(listStrings);
  }
}
