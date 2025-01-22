import 'package:flutter/material.dart';
import 'package:supa_session/login_screen.dart';
import 'package:supa_session/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://qtnmglbptruyumgjswpx.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0bm1nbGJwdHJ1eXVtZ2pzd3B4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NDI3OTksImV4cCI6MjA1MzAxODc5OX0.sF9E7sC0dpRStE7ME6GAoav-4hGhXlxn3DDx9mam98k';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final authState = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (authState == null) {
          return Text("Some Error Occured");
        } else {
          final session = authState.session;
          if (session != null) {
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
