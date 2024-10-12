import 'package:example_app/db/tables/test/test_model.dart';
import 'package:example_app/my_list_item_detail.dart';
import 'package:flutter/material.dart';

class MyListItem extends StatelessWidget {
  const MyListItem({
    super.key,
    required this.record,
    required this.onDelete,
    required this.onUpdate,
  });

  final Test record;
  final void Function(int) onDelete;
  final void Function(int) onUpdate;

  Future<bool?> _confirmDelete(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to delete ${record.id}.'),
                const Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes, delete!'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        confirmDismiss: (direction) {
          if (direction != DismissDirection.endToStart) {
            onUpdate(record.id!);
            return Future.value(false);
          } else {
            return _confirmDelete(context);
          }
        },
        key: ValueKey(record.id),
        background: Container(
          color: Colors.green,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            record.text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            children: [
              MyListItemDetail(
                label: 'Primary Key',
                text: record.id.toString(),
              ),
              MyListItemDetail(
                label: 'Integer',
                text: record.number.toString(),
              ),
              MyListItemDetail(
                label: 'Double',
                text: record.numeric.toString(),
              ),
              MyListItemDetail(
                label: 'Date',
                text: record.date.toString(),
              ),
              MyListItemDetail(
                label: 'Boolean',
                text: record.isChecked.toString(),
              ),
              MyListItemDetail(
                label: 'Blob',
                text: String.fromCharCodes(record.anything),
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            onDelete(record.id!);
          }
        });
  }
}
