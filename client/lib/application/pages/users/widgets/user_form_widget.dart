import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  _CreateUserFormState createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int? _selectedGroup = 1;

  final List<Map<String, dynamic>> _groups = [
    {"id": 1, "name": "Admin"},
    {"id": 2, "name": "User"},
    {"id": 3, "name": "Guest"}
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
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
          DropdownButtonHideUnderline(
              child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: "Group"),
              value: _selectedGroup,
              items: _groups.map((group) {
                return DropdownMenuItem<int>(
                  value: group['id'] as int,
                  child: SizedBox(
                      width: 150,
                      child:
                          Text(group['name'], overflow: TextOverflow.ellipsis)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGroup = value!;
                });
              },
              validator: (value) =>
                  value == null ? "Please select a group" : null,
            ),
          )),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final userModel = UserModel(
                  id: 0,
                  firstName: _firstNameController.text,
                  email: _emailController.text,
                  group: {"groupId": _selectedGroup},
                );
                context.read<UserBloc>().add(
                      AddUser(userModel),
                    );
                _firstNameController.clear();
                _emailController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text("Save User"),
          ),
        ],
      ),
    );
  }
}
