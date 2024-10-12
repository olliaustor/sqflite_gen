import 'dart:typed_data';

import 'package:example_app/db/database.dart';
import 'package:example_app/db/db.dart';
import 'package:example_app/my_list_item.dart';
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

  void _updateRecord(int id) async {
    final record = _list.firstWhere((item) => item.id == id);
    final table = TestProvider(database);
    await table.update(record.copyWith(date: DateTime.now()));
    _showSnackBar('$id updated');
    _updateList(table);
  }

  void _deleteRecord(int id) async {
    final table = TestProvider(database);
    await table.delete(id);
    _showSnackBar('$id deleted');
    _updateList(table);
  }

  void _updateList(TestProvider table) async {
    final allRecords = await table.getAll();
    setState(() {
      _list = allRecords;
    });
  }

  void _showSnackBar(String text) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: _list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => MyListItem(
          key: ValueKey(_list[index].id),
          record: _list[index],
          onDelete: _deleteRecord,
          onUpdate: _updateRecord,
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
