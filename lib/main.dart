import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Login with Alert & Snackbar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  String imageSource = "images/question.png"; // default image

  final EncryptedSharedPreferences _securePrefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedCredentials(); // load saved login info when app starts
  }

  // Load saved data and show Snackbar if data exists
  void _loadSavedCredentials() async {
    String? loginName = await _securePrefs.getString("loginName");
    String? password = await _securePrefs.getString("password");

    if (loginName != null && password != null) {
      setState(() {
        _loginController.text = loginName;
        _passwordController.text = password;
      });

      // Show snackbar when credentials loaded
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Previous login loaded.")),
        );
      });
    }
  }

  // Prompt user with AlertDialog to save credentials
  void _handleLogin() {
    String enteredPassword = _passwordController.text;
    setState(() {
      imageSource = (enteredPassword == "QWERTY123")
          ? "images/lightbulb.png"
          : "images/stop.png";
    });

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save Credentials'),
        content: const Text('Would you like to save your login info?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Save credentials to encrypted storage
              await _securePrefs.setString("loginName", _loginController.text);
              await _securePrefs.setString("password", _passwordController.text);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () async {
              // Remove any saved credentials
              await _securePrefs.remove("loginName");
              await _securePrefs.remove("password");
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: "Login Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text("Login"),
            ),
            const SizedBox(height: 16),
            Image.asset(imageSource, width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}
