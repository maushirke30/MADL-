// Before running this practical:
// 1. Configure a Firebase project with FlutterFire CLI (`flutterfire configure`).
// 2. Add dependencies: flutter pub add firebase_core cloud_firestore
// 3. Ensure lib/firebase_options.dart exists and exports
//    DefaultFirebaseOptions.currentPlatform.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Students(),
  ));
}

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final controller = TextEditingController();
  final students = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent() async {
    final name = controller.text.trim();
    if (name.isEmpty) return;
    await students.add({'name': name, 'createdAt': FieldValue.serverTimestamp()});
    controller.clear();
  }

  Future<void> deleteStudent(String id) async {
    await students.doc(id).delete();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Student Database')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addStudent,
                child: const Text('Add Student'),
              ),
              const Divider(),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: students.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return const Center(child: Text('No students'));
                    }
                    return ListView(
                      children: docs.map((doc) {
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(doc.data()['name'] as String? ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteStudent(doc.id),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
