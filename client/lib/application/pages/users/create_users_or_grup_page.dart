import 'package:client/application/pages/users/widgets/appbar_widget.dart';
import 'package:client/application/pages/users/widgets/group_form_widget.dart';
import 'package:client/application/pages/users/widgets/user_form_widget.dart';
import 'package:flutter/material.dart';

class CreateUserOrGroupPage extends StatefulWidget {
  const CreateUserOrGroupPage({super.key});

  @override
  _CreateUserOrGroupPageState createState() => _CreateUserOrGroupPageState();
}

class _CreateUserOrGroupPageState extends State<CreateUserOrGroupPage> {
  String _selectedForm = 'User';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: "Create User or Group",
        themeData: themeData,
        widgetAction: SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
