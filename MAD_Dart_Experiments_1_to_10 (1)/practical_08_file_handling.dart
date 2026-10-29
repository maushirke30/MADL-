import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notes(),
    ));

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final controller = TextEditingController();
  String data = 'No notes';

  Future<File> _notesFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/notes.txt');
  }

  Future<void> save() async {
    if (controller.text.trim().isEmpty) return;
    final file = await _notesFile();
    final date = DateFormat('dd MMM').format(DateTime.now());
    await file.writeAsString(
      '[$date] ${controller.text.trim()}\\n',
      mode: FileMode.append,
    );
    controller.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note saved')),
      );
    }
  }

  Future<void> read() async {
    final file = await _notesFile();
    final contents = await file.exists() ? await file.readAsString() : 'Empty';
    if (mounted) setState(() => data = contents);
  }

  Future<void> delete() async {
    final file = await _notesFile();
    if (await file.exists()) await file.delete();
    if (mounted) setState(() => data = 'Deleted');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Notes')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Write note'),
              ),
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(onPressed: save, child: const Text('Save')),
                  TextButton(onPressed: read, child: const Text('Read')),
                  TextButton(onPressed: delete, child: const Text('Delete')),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(child: Text(data)),
              ),
            ],
          ),
        ),
      );
}
