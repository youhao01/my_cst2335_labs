import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'repository.dart'; // Data repository
import 'ProfilePage.dart'; // Second page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 - Navigation & Repository',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Login Page'),
        '/profile': (context) => const ProfilePage(),
      },
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
  String imageSource = "images/question.png";
  final EncryptedSharedPreferences _securePrefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedCredentials();
  }

  // Load login info and user data
  void _loadSavedCredentials() async {
    String? loginName = await _securePrefs.getString("loginName");
    String? password = await _securePrefs.getString("password");

    if (loginName != null && password != null) {
      setState(() {
        _loginController.text = loginName;
        _passwordController.text = password;
      });

      // Load profile info (first name, last name, etc.)
      await DataRepository.loadData();

      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Previous login loaded.")),
        );
      });
    }
  }

  // Handle login logic and dialog
  void _handleLogin() {
    String enteredPassword = _passwordController.text;

    setState(() {
      imageSource = (enteredPassword == "QWERTY123")
          ? "images/lightbulb.png"
          : "images/stop.png";
    });

    if (enteredPassword == "QWERTY123") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Save Credentials'),
          content: const Text('Would you like to save your login info?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _securePrefs.setString("loginName", _loginController.text);
                await _securePrefs.setString("password", _passwordController.text);
                DataRepository.loginName = _loginController.text;
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(content: Text("Welcome back, ${_loginController.text}!")),
                );

                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(this.context, rootNavigator: true).pushNamed('/profile');
                });
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () async {
                await _securePrefs.remove("loginName");
                await _securePrefs.remove("password");

                DataRepository.loginName = _loginController.text;
                await DataRepository.loadData(); // still load rest info

                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.of(this.context, rootNavigator: true).pushNamed('/profile');
                });
              },
              child: const Text('No'),
            ),
          ],
        ),
      );
    }
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
