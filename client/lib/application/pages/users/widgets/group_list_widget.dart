import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget(
      {super.key, required this.themeData, required this.state});

  final ThemeData themeData;
  final GroupLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.groups.length,
      itemBuilder: (context, index) {
        final group = state.groups[index];
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
                  themeData.colorScheme.primary.withOpacity(0.35),
                  themeData.colorScheme.secondary.withOpacity(0.45),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.read<UserBloc>().add(
                                GetFilterUsers(group.name),
                              );
                        },
                        child: Text(
                          group.name,
                          style: themeData.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
