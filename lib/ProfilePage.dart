import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'repository.dart';

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
    _initializeData();
    _addListeners();
  }

  Future<void> _initializeData() async {
    await DataRepository.loadData(); // 加载加密存储中的数据

    setState(() {
      _firstNameController.text = DataRepository.firstName;
      _lastNameController.text = DataRepository.lastName;
      _phoneController.text = DataRepository.phone;
      _emailController.text = DataRepository.email;
    });
  }

  void _addListeners() {
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Unsupported Action"),
          content: Text("Cannot launch: $url"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextFieldRow({
    required TextEditingController controller,
    required String label,
    List<Widget>? suffixButtons,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        if (suffixButtons != null) const SizedBox(width: 8),
        if (suffixButtons != null)
          ...suffixButtons.map((btn) => Padding(
            padding: const EdgeInsets.only(left: 4),
            child: btn,
          )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back: ${DataRepository.loginName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextFieldRow(
              controller: _firstNameController,
              label: "First Name",
            ),
            const SizedBox(height: 12),
            _buildTextFieldRow(
              controller: _lastNameController,
              label: "Last Name",
            ),
            const SizedBox(height: 12),
            _buildTextFieldRow(
              controller: _phoneController,
              label: "Phone Number",
              suffixButtons: [
                IconButton(
                  onPressed: () {
                    if (_phoneController.text.isNotEmpty) {
                      _launchUrl("tel:${_phoneController.text}");
                    }
                  },
                  icon: const Icon(Icons.phone),
                ),
                IconButton(
                  onPressed: () {
                    if (_phoneController.text.isNotEmpty) {
                      _launchUrl("sms:${_phoneController.text}");
                    }
                  },
                  icon: const Icon(Icons.message),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextFieldRow(
              controller: _emailController,
              label: "Email address",
              suffixButtons: [
                IconButton(
                  onPressed: () {
                    if (_emailController.text.isNotEmpty) {
                      _launchUrl("mailto:${_emailController.text}");
                    }
                  },
                  icon: const Icon(Icons.mail),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
