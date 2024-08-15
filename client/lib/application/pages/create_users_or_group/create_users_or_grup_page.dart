import 'package:flutter/material.dart';

class CreateUserOrGroupPage extends StatefulWidget {
  const CreateUserOrGroupPage({super.key});

  @override
  _CreateUserOrGroupPageState createState() => _CreateUserOrGroupPageState();
}

class _CreateUserOrGroupPageState extends State<CreateUserOrGroupPage> {
  String _selectedForm = 'User'; // Opção padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create User or Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Choose what to create:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("User"),
                    value: 'User',
                    groupValue: _selectedForm,
                    onChanged: (value) {
                      setState(() {
                        _selectedForm = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Group"),
                    value: 'Group',
                    groupValue: _selectedForm,
                    onChanged: (value) {
                      setState(() {
                        _selectedForm = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _selectedForm == 'User'
                  ? const CreateUserForm()
                  : const CreateGroupForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  _CreateUserFormState createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGroup;

  final List<String> _groups = ["Admin", "User", "Guest"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: "First Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter the first name";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: "Last Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter the last name";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter the email";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Group"),
            value: _selectedGroup,
            items: _groups.map((group) {
              return DropdownMenuItem(
                value: group,
                child: Text(group),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGroup = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a group";
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final firstName = _firstNameController.text;
                final lastName = _lastNameController.text;
                final email = _emailController.text;
                final group = _selectedGroup;

                print("First Name: $firstName");
                print("Last Name: $lastName");
                print("Email: $email");
                print("Group: $group");
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(),
            child: const Text("Save User"),
          ),
        ],
      ),
    );
  }
}

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({super.key});

  @override
  _CreateGroupFormState createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _groupNameController,
            decoration: const InputDecoration(labelText: "Group Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter the group name";
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Lógica para salvar o grupo
                final groupName = _groupNameController.text;

                print("Group Name: $groupName");

                Navigator.pop(context);
              }
            },
            child: const Text("Save Group"),
          ),
        ],
      ),
    );
  }
}
