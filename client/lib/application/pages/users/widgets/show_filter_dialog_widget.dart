import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/widgets/empty_message_widget.dart';
import 'package:client/application/pages/users/widgets/group_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFilterDialogWidget(BuildContext context) {
  final themeData = Theme.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Filter by group'),
        content: SizedBox(
          height: 200,
          width: 250,
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupInitial) {
                return const Text("Group initial");
              } else if (state is GroupLoading) {
                return CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                );
              } else if (state is GroupLoaded) {
                if (state.groups.isEmpty) {
                  return EmptyListWidget(
                    themeData: themeData,
                    message: "Please create first a group",
                  );
                } else {
                  return GroupsListWidget(
                    themeData: themeData,
                    state: state,
                  );
                }
              } else if (state is GroupError) {
                return Text(state.message);
              }

              return const SizedBox();
            },
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              child: const Text(
                'Cancel',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
