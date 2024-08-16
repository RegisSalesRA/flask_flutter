import 'package:client/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection.dart';
import '../users/bloc/users_bloc_bloc.dart';

class CreateUserOrGroupPage extends StatefulWidget {
  const CreateUserOrGroupPage({super.key});

  @override
  _CreateUserOrGroupPageState createState() => _CreateUserOrGroupPageState();
}

class _CreateUserOrGroupPageState extends State<CreateUserOrGroupPage> {
  String _selectedForm = 'User';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UsersBlocBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create User or Group"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
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
  int? _selectedGroup = 1;

  final List<int> _groups = [1, 2, 3];

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
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: "1"),
            value: _selectedGroup,
            items: _groups.map((group) {
              return DropdownMenuItem(
                value: group,
                child: Text(group.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGroup = value!;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a group";
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final userModel = UserModel(
                  id: 0,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  group: {"groupId": _selectedGroup},
                );
                context.read<UsersBlocBloc>().add(
                      UserPostRequestedEvent(user: userModel),
                    );
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
