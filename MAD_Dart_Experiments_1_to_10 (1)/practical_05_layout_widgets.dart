import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Profile(),
    ));

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    const subjects = ['MAD', 'DBMS', 'DSA', 'CN', 'AI/ML', 'Cloud'];
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.deepPurple,
                ),
                const CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 45),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Anushka Shirke',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const Text('Information Technology Student'),
            const SizedBox(height: 15),
            Row(
              children: [
                _stat('12', 'Projects'),
                _stat('340', 'Followers'),
                _stat('89', 'Following'),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Flutter')),
                  Chip(label: Text('Dart')),
                  Chip(label: Text('Python')),
                  Chip(label: Text('Java')),
                ],
              ),
            ),
            const Text('Subjects',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: subjects
                  .map((subject) => Card(
                        child: Center(child: Text(subject)),
                      ))
                  .toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit Profile'),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _stat(String number, String label) => Expanded(
        child: Column(
          children: [
            Text(number,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label),
          ],
        ),
      );
}
