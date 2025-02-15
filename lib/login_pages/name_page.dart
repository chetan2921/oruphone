import 'package:flutter/material.dart';
import 'package:oruphone/screens/home_screen.dart'; // Import your home screen

class NameInput extends StatefulWidget {
  const NameInput({super.key, required this.name});

  final String? name;

  @override
  State<NameInput> createState() => _LoginPageState();
}

class _LoginPageState extends State<NameInput> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _confirmName() async {
    String enteredName = _textController.text.trim();
    if (enteredName.isEmpty) {
      // Show an error if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    // Navigate to the home screen directly
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePageWidget(userName: enteredName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Enter Your Name to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please tell us your name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: _confirmName, // Call the updated method
                  icon: const Icon(Icons.east, size: 15, color: Colors.white),
                  label: const Text('Confirm Name'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16088D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
