import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/widgets/empty_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_model.dart';

class UserFormModal extends StatefulWidget {
  final int id;
  final String email;
  final String firstName;
  final Map group;

  const UserFormModal({
    required this.id,
    required this.email,
    required this.firstName,
    required this.group,
  });

  @override
  _UserFormModalState createState() => _UserFormModalState();
}

class _UserFormModalState extends State<UserFormModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int? _selectedGroup;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _firstNameController.text = widget.firstName;
    _selectedGroup = widget.group['id'];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Update User",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                cursorColor: Colors.white,
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the first name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.white,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
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
              BlocBuilder<GroupBloc, GroupState>(
                builder: (context, state) {
                  if (state is GroupLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  } else if (state is GroupLoaded) {
                    final loadedGroups = state.groups;
                    if (loadedGroups.isEmpty) {
                      return EmptyListWidget(
                        themeData: themeData,
                        message: "Please create a group first",
                      );
                    } else {
                      return Column(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: "Group",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items: loadedGroups.map((group) {
                                return DropdownMenuItem<int>(
                                  value: group.id,
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      group.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: _selectedGroup,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGroup = value;
                                });
                              },
                              validator: (value) => value == null
                                  ? "Please select a group"
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    }
                  } else if (state is GroupError) {
                    return Text(state.message);
                  }

                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final userModel = UserModel(
                id: widget.id,
                firstName: _firstNameController.text,
                email: _emailController.text,
                group: {"id": _selectedGroup},
              );
              context.read<UserBloc>().add(UpdateUser(userModel));
              Navigator.pop(context);
            }
          },
          child: const Text("Update User"),
        ),
      ],
    );
  }
}
