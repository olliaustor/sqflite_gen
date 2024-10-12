import 'dart:typed_data';

import 'package:example_app/db/database.dart';
import 'package:example_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';

const dbName = 'test.db';
late Database database;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqflite_Gen Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sqflite_Gen Demo Home Page'),
    );
  }
}

class MyListItemDetail extends StatelessWidget {
  const MyListItemDetail({super.key, required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          stepWidth: 80,
          child: Text(label),
        ),
        Text(text),
      ],
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
  List<Test> _list = [];
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  void _initDatabase() async {
    database = await openDatabaseWithMigration(dbName);
    final table = TestProvider(database);
    _updateList(table);
  }

  void _addRecord() async {
    final guid = uuid.v4();
    final newRecord = Test(
        text: guid,
        number: _list.length,
        numeric: _list.length / 2,
        date: DateTime.now(),
        isChecked: _list.length % 2 != 0,
        anything: Uint8List.fromList(guid.codeUnits),
    );

    final table = TestProvider(database);
    await table.insert(newRecord);
    _updateList(table);
  }

  void _updateList(TestProvider table) async {
    final allRecords = await table.getAll();
    setState(() {
      _list = allRecords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
      itemCount: _list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          _list[index].text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          children: [
            MyListItemDetail(
              label: 'Integer',
              text: _list[index].number.toString(),
            ),
            MyListItemDetail(
              label: 'Double',
              text: _list[index].numeric.toString(),
            ),
            MyListItemDetail(
              label: 'Date',
              text: _list[index].date.toString(),
            ),
            MyListItemDetail(
              label: 'Boolean',
              text: _list[index].isChecked.toString(),
            ),
            MyListItemDetail(
              label: 'Blob',
              text: String.fromCharCodes(_list[index].anything),
            ),
          ],
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecord,
        tooltip: 'Add record to database',
        child: const Icon(Icons.add),
      ),
    );
  }
}
