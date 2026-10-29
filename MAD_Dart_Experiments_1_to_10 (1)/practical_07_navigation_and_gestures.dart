import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/details': (_) => const Details(),
        '/gestures': (_) => const Gestures(),
      },
    ));

class Home extends StatelessWidget {
  Home({super.key});

  final subjects = const ['MAD', 'DBMS', 'DSA', 'CN'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Study Hub'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/gestures'),
              icon: const Icon(Icons.touch_app),
            ),
          ],
        ),
        body: ListView(
          children: subjects
              .map(
                (subject) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(subject),
                    subtitle: const Text('View subject details'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Details(subject: subject),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}

class Details extends StatelessWidget {
  const Details({super.key, this.subject});
  final String? subject;

  @override
  Widget build(BuildContext context) {
    final selected = subject ??
        (ModalRoute.of(context)?.settings.arguments as String? ?? 'MAD');
    return Scaffold(
      appBar: AppBar(title: Text(selected)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$selected Subject',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text('Study material and practical work'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class Gestures extends StatefulWidget {
  const Gestures({super.key});

  @override
  State<Gestures> createState() => _GesturesState();
}

class _GesturesState extends State<Gestures> {
  String message = 'Touch the box';
  Color color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Gestures')),
        body: Center(
          child: GestureDetector(
            onTap: () => setState(() => message = 'Single Tap'),
            onDoubleTap: () => setState(() {
              message = 'Double Tap';
              color = Colors.green;
            }),
            onLongPress: () => setState(() => message = 'Long Press'),
            child: Container(
              width: 180,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(message,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ),
      );
}
