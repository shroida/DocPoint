import 'package:docpoint/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewPasswordScreen extends StatefulWidget {
  final String code; // Accepting the code parameter from the redirect URL

  const NewPasswordScreen({super.key, required this.code});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _updatePassword() async {
    final newPassword = _passwordController.text.trim();
    if (newPassword.isEmpty) return;

    setState(() => _loading = true);

    try {
      // Use the code (token) to verify or perform the password update
      final response = await Supabase.instance.client.auth
          .exchangeCodeForSession(
              widget.code); // Assuming this method works for your case

      // Once we have the session, update the password
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating password: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set New Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updatePassword,
                    child: Text("Update Password"),
                  ),
            ElevatedButton(
              onPressed: () {
                context.pushReplacement(Routes.loginScreen);
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
