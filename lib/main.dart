import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No bullshit ToDo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentProject = "Root";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentProject),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
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

  _addProject(value) {
    setState(() {
      // actionsList.removeWhere((item) => item == value);
      projectsList.add(value);
    });
  }

  Widget _getCheckboxTile(type, item, theme) {
    var style = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    if (type == "action") {
      return GestureDetector(
        onDoubleTap: _addProject(item),
        child: CheckboxListTile(
          title: Text(
            item,
            style: style,
          ),
          tileColor: theme.colorScheme.primary,
          value: false,
          onChanged: onChanged,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );
    } else {
      return CheckboxListTile(
        title: Text(
          item,
          style: style,
        ),
        tileColor: theme.secondaryHeaderColor,
        value: false,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ListView(
      children: [
        for (var item in actionsList) _getCheckboxTile("action", item, theme),
        for (var item in projectsList) _getCheckboxTile("project", item, theme),
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
