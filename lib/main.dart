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
      home: const MyHomePage(title: 'My ToDo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ActionList(),
        ),
      ),
    );
  }
}

class ActionList extends StatefulWidget {
  @override
  State<ActionList> createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  var actionItems = [];

  void onChanged(value) {}
  void _addAction(value) {
    setState(() {
      actionItems.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return ListView(
      children: [
        for (var action in actionItems)
          CheckboxListTile(
            title: Text(
              action,
              style: style,
            ),
            tileColor: theme.colorScheme.primary,
            value: false,
            onChanged: onChanged,
            controlAffinity: ListTileControlAffinity.leading,
          ),
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
