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
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'My ToDo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var actionItems = [];
  var groupItems = [];

  void _addGroup() {
    setState(() {
      groupItems.add("Group1");
    });
  }

  void _addAction() {
    setState(() {
      actionItems.add("Action1");
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          for (var action in actionItems)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                tileColor: Colors.white,
                title: Text(
                  action,
                  style: style,
                ),
                value: false,
                onChanged: (bool? value) {},
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          for (var group in groupItems) GroupCard(group: group),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _addAction,
            tooltip: 'Add Action',
            child: const Icon(Icons.checklist_outlined),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: _addGroup,
            tooltip: 'Add Group',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required group,
  }) : super(key: key);

  final String group = "Default";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            group,
            style: style,
          ),
        ),
      ),
    );
  }
}
