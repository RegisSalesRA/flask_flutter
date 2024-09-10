import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/widgets/form_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget(
      {super.key, required this.themeData, required this.state});

  final ThemeData themeData;
  final UserStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        final user = state.users[index];
        return Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeData.colorScheme.primary.withOpacity(0.15),
                  themeData.colorScheme.secondary.withOpacity(0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.firstName,
                        style: themeData.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user.email,
                        style: themeData.textTheme.bodyMedium?.copyWith(
                          color:
                              themeData.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeData.colorScheme.secondary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.group['name'] ?? "Unknow",
                          style: themeData.textTheme.bodySmall?.copyWith(
                            color: themeData.colorScheme.onSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: themeData.colorScheme.secondary,
                        size: 20,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              UserFormModal(id: user.id),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: themeData.colorScheme.error,
                        size: 20,
                      ),
                      onPressed: () {
                        context.read<UserBloc>().add(DeleteUser(user.id));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
