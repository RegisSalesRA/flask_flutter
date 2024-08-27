import 'package:flutter/material.dart';

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({super.key});

  @override
  _CreateGroupFormState createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts size to fit content
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
                final groupName = _groupNameController.text;
                print("Group Name: $groupName");
                _groupNameController.clear();
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
