import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _supabaseAuth = Supabase.instance.client.auth;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide password
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  
                    final res = await _supabaseAuth.signInWithPassword(
                      email: _email.text.trim(),
                      password: _password.text,
                    );
                    if (res.user != null) {
                    print("Login successful");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const MainScreen()),
                    // );
                    } 
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
