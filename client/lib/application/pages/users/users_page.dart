import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/create_users_or_grup_page.dart';
import 'package:client/application/pages/users/widgets/appbar_widget.dart';
import 'package:client/application/pages/users/widgets/user_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/empty_message_widget.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBarWidget(
        themeData: themeData,
        title: "Flask Flutter Bloc",
        widgetAction: SizedBox(),
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
                      if (state is UserInitial) {
                        return const Text("User initial");
                      } else if (state is UserLoading) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        );
                      } else if (state is UserLoaded) {
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
                      } else if (state is UserError) {
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
  }
}
