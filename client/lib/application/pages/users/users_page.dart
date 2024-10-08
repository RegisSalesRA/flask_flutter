import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/create_users_or_grup_page.dart';
import 'package:client/application/pages/users/widgets/appbar_widget.dart';
import 'package:client/application/pages/users/widgets/user_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/empty_message_widget.dart';
import 'widgets/show_filter_dialog_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(GetUsers());
      context.read<GroupBloc>().add(LoadGroups());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBarWidget(
            themeData: themeData,
            title: "Flask Flutter Bloc",
            widgetAction: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: themeData.colorScheme.secondary,
                  ),
                  onPressed: () {
                    context.read<UserBloc>().add(GetUsers());
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: themeData.colorScheme.secondary,
                  ),
                  onPressed: () {
                    showFilterDialogWidget(context);
                  },
                )
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserStateInitial) {
                            return const Text("User initial");
                          } else if (state is UserStateLoading) {
                            return CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            );
                          } else if (state is UserStateLoaded) {
                            if (state.users.isEmpty) {
                              return EmptyListWidget(
                                themeData: themeData,
                                message: "No users found!",
                              );
                            } else {
                              return UsersListWidget(
                                themeData: themeData,
                                state: state,
                              );
                            }
                          } else if (state is UserStateError) {
                            return Text(state.message);
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateUserOrGroupPage(),
                ),
              );
            },
            backgroundColor: themeData.colorScheme.secondary,
            child: Icon(
              Icons.add,
              color: themeData.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
