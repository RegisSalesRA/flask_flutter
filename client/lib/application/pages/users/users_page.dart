import 'package:client/application/core/services/theme_service.dart';
import 'package:client/application/pages/users/bloc/users_bloc_bloc.dart';
import 'package:client/application/pages/users/widgets/custom_button.dart';
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
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is UserStateLoaded) {
                      return ListView.builder(
                          itemCount: state.user
                              .length, // Assumindo que `user` é uma lista de `UserModel`
                          itemBuilder: (context, index) {
                            final user = state.user[index];
                            return ListTile(
                              title: Text('${user.firstName} ${user.lastName}'),
                              subtitle: Text(user.email),
                              trailing: Text(user.group['name']),
                            );
                          });
                    } else if (state is UserStateError) {
                      return Text(state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
