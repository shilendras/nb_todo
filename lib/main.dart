import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var appData = {
  "root": {
    "actions": ["buy lap", "see video"],
    "projects": ["get out"]
  },
  "get out": {
    "actions": ["resume", "notice"],
    "projects": ["kb4 project"]
  },
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'No bullshit ToDo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentProj = "root";

  void changeCurrProject(newProj) {
    currentProj = newProj;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.currentProj),
      ),
      body: Center(
        child: Container(
          // color: Theme.of(context).colorScheme.primaryContainer,
          child: const ItemList(),
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  var actionsList = [];
  var projectsList = [];

  void onChanged(value) {}
  void _addAction(value) {
    setState(() {
      actionsList.add(value);
    });
  }

  void _addProject(value) {
    setState(() {
      actionsList.removeWhere((item) => item == value);
      projectsList.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = context.watch<MyAppState>();
    var currentProj = appState.currentProj;
    actionsList = appData[currentProj]!["actions"]!;
    projectsList = appData[currentProj]!["projects"]!;

    Widget getCheckboxTile(type, item) {
      var projStyle = theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
      if (type == "action") {
        return GestureDetector(
          onDoubleTap: () => _addProject(item),
          child: CheckboxListTile(
            title: Text(
              item,
              style: style,
            ),
            tileColor: Colors.blue,
            value: false,
            onChanged: onChanged,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      } else if (type == "project") {
        return GestureDetector(
          onDoubleTap: () => appState.changeCurrProject(item),
          child: CheckboxListTile(
            title: Text(
              item,
              style: projStyle,
            ),
            tileColor: Colors.purple,
            value: false,
            onChanged: onChanged,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      } else {
        return const Text("hello");
      }
    }

    return ListView(
      children: [
        for (var item in actionsList) getCheckboxTile("action", item),
        for (var item in projectsList) getCheckboxTile("project", item),
        CheckboxListTile(
          title: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "add first action",
            ),
            textInputAction: TextInputAction.go,
            onFieldSubmitted: _addAction,
          ),
          tileColor: theme.colorScheme.primary,
          value: false,
          onChanged: onChanged,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }
}
