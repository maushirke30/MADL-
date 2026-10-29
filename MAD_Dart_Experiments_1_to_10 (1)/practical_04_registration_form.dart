import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    ));

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? course;
  bool agree = false;

  void submit() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid && agree) {
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Registration Successful'),
          content: Text(
            'Welcome ${nameController.text}!\\n'
            'Course: $course\\nEmail: ${emailController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Accept the terms')),
      );
    }
  }

  void resetForm() {
    formKey.currentState?.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    setState(() {
      course = null;
      agree = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Student Registration')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter name'
                          : null,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value != null && value.contains('@')
                      ? null
                      : 'Enter valid email',
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) =>
                      value == null || value.length < 6
                          ? 'Minimum 6 characters'
                          : null,
                ),
                DropdownButtonFormField<String>(
                  initialValue: course,
                  decoration: const InputDecoration(labelText: 'Course'),
                  items: const ['BSc IT', 'BSc CS', 'BCA']
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => course = value),
                  validator: (value) =>
                      value == null ? 'Select course' : null,
                ),
                CheckboxListTile(
                  title: const Text('Accept Terms'),
                  value: agree,
                  onChanged: (value) =>
                      setState(() => agree = value ?? false),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: submit,
                        child: const Text('Register'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: resetForm,
                        child: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
