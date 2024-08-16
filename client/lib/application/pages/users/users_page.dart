import 'package:client/application/core/services/theme_service.dart';
import 'package:client/application/pages/create_users_or_group/create_users_or_grup_page.dart';
import 'package:client/application/pages/users/bloc/users_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../injection.dart';

class UserPageProvider extends StatelessWidget {
  const UserPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UsersBlocBloc>(),
      child: const UserPage(),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) { 
    final client = http.Client();
    final userRemoteDatasource = UserRemoteDatasourceImpl(client: client);
    final userRepo = UserRepoImpl(userRemoteDatasource: userRemoteDatasource);
    final userUseCases = UserUseCases(userRepo: userRepo);
    final usersBloc = UsersBlocBloc(userUseCases: userUseCases);

    return BlocProvider(
      create: (context) => usersBloc,
      child: const UserPage(),
    );
  }
 */

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBlocBloc>().add(UserRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users list",
          style: themeData.textTheme.bodyLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<UsersBlocBloc, UsersBlocState>(
                  builder: (context, state) {
                    if (state is UsersBlocInitial) {
                      return const Text("User initial");
                    } else if (state is UserStateLoading) {
                      return CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    } else if (state is UserStateLoaded) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.user.length,
                        itemBuilder: (context, index) {
                          final user = state.user[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              title: Text(
                                '${user.firstName} ${user.lastName}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              subtitle: Text(
                                user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                              trailing: Chip(
                                label: Text(
                                  user.group['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        },
                      );
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
