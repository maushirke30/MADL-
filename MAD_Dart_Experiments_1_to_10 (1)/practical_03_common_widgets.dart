import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Study(),
    ));

class Study extends StatefulWidget {
  const Study({super.key});

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
  bool reminders = true;
  bool madDone = false;
  bool dbmsDone = true;
  double hours = 3;
  int tasks = 2;

  void addTask() {
    setState(() => tasks++);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task added!')),
    );
  }

  void showGoal() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Today's Goal"),
        content: Text('Study ${hours.round()} hours today.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('StudyFlow'),
          actions: [
            IconButton(
              onPressed: showGoal,
              icon: const Icon(Icons.person),
              tooltip: 'View goal',
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Good morning!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Today's Progress",
                            style: TextStyle(color: Colors.white)),
                        Text('$tasks tasks planned',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const LinearProgressIndicator(value: 0.5),
                      ],
                    ),
                  ),
                  const Icon(Icons.auto_graph, color: Colors.white, size: 35),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Today's Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              child: CheckboxListTile(
                value: madDone,
                onChanged: (value) => setState(() => madDone = value ?? false),
                title: const Text('MAD Practical'),
                subtitle: const Text('Complete Flutter practical'),
              ),
            ),
            Card(
              child: CheckboxListTile(
                value: dbmsDone,
                onChanged: (value) => setState(() => dbmsDone = value ?? false),
                title: const Text('DBMS Revision'),
                subtitle: const Text('Revise SQL queries'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.code),
                title: const Text('DSA Practice'),
                subtitle: const Text('Solve coding problems'),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening DSA task...')),
                ),
              ),
            ),
            const Text('Focus Goal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Slider(
              value: hours,
              min: 1,
              max: 8,
              divisions: 7,
              label: '${hours.round()} hours',
              onChanged: (value) => setState(() => hours = value),
            ),
            SwitchListTile(
              title: const Text('Study reminders'),
              value: reminders,
              onChanged: (value) => setState(() => reminders = value),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addTask,
                    child: const Text('Add Task'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: showGoal,
                  child: const Text('View Goal'),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTask,
          child: const Icon(Icons.add),
        ),
      );
}
