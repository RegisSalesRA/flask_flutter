import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/widgets/empty_message_widget.dart';
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupBloc>().add(LoadGroups());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            cursorColor: Colors.white,
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
            cursorColor: Colors.white,
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
          BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupInitial) {
                return const Text("Group initial");
              } else if (state is GroupLoading) {
                return CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                );
              } else if (state is GroupLoaded) {
                final loadedGroups = state.groups;
                if (state.groups.isEmpty) {
                  return EmptyListWidget(
                    themeData: themeData,
                    message: "Please create first a group",
                  );
                } else {
                  return Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<int>(
                            decoration:
                                const InputDecoration(labelText: "Group"),
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
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedGroup = value!;
                              });
                              print(value);
                            },
                            validator: (value) =>
                                value == null ? "Please select a group" : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final userModel = UserModel(
                              id: 0,
                              firstName: _firstNameController.text,
                              email: _emailController.text,
                              group: {"id": _selectedGroup},
                            );
                            context.read<UserBloc>().add(
                                  PostUser(userModel),
                                );
                            _firstNameController.clear();
                            _emailController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save User"),
                      ),
                    ],
                  );
                }
              } else if (state is GroupError) {
                return Text(state.message);
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
