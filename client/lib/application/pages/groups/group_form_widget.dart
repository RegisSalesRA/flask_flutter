import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/data/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  GroupModel group =
                      GroupModel(id: 0, name: _groupNameController.text);
                  context.read<GroupBloc>().add(AddGroup(group));
                  _groupNameController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save Group"),
            ),
          ],
        ),
      ),
    );
  }
}
