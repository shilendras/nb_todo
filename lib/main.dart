import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        home: MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.currentProj),
      ),
      body: Center(
        child: Container(
          // color: Theme.of(context).colorScheme.primaryContainer,
          child: ItemList(),
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
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

    Widget getCheckboxTile(type, item) {
      var style = theme.textTheme.bodyText1!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
      var proj_style = theme.textTheme.bodyLarge!.copyWith(
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
          onTap: () => appState.changeCurrProject(item),
          child: CheckboxListTile(
            title: Text(
              item,
              style: proj_style,
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
