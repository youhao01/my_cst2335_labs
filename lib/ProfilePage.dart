import 'package:flutter/material.dart';
import 'repository.dart'; // 确保导入你的 Repository 类

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load repository data
    _firstNameController.text = DataRepository.firstName;
    _lastNameController.text = DataRepository.lastName;
    _phoneController.text = DataRepository.phone;
    _emailController.text = DataRepository.email;

    // Save on every change
    _firstNameController.addListener(() {
      DataRepository.firstName = _firstNameController.text;
      DataRepository.saveData();
    });
    _lastNameController.addListener(() {
      DataRepository.lastName = _lastNameController.text;
      DataRepository.saveData();
    });
    _phoneController.addListener(() {
      DataRepository.phone = _phoneController.text;
      DataRepository.saveData();
    });
    _emailController.addListener(() {
      DataRepository.email = _emailController.text;
      DataRepository.saveData();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back: ${DataRepository.loginName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    // To be implemented: phone call
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    // To be implemented: SMS
                  },
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email address'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {
                    // To be implemented: mailto
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
