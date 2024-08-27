import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/create_users_or_grup_page.dart';
import 'package:client/application/pages/users/widgets/appbar_widget.dart';
import 'package:client/application/pages/users/widgets/form_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../core/services/theme_service.dart';

class UserPageProvider extends StatefulWidget {
  const UserPageProvider({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPageProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(LoadUsers());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBarWidget(
        themeData: themeData,
        title: "Flask Flutter Bloc",
        widgetAction: Switch(
          value: Provider.of<ThemeService>(context).isDarkModeOn,
          onChanged: (_) {
            Provider.of<ThemeService>(context, listen: false).toggleTheme();
          },
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
                      if (state is UserInitial) {
                        return const Text("User initial");
                      } else if (state is UserLoading) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        );
                      } else if (state is UserLoaded) {
                        return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return Card(
                              elevation: 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      themeData.colorScheme.primary
                                          .withOpacity(0.15),
                                      themeData.colorScheme.secondary
                                          .withOpacity(0.15),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.firstName,
                                            style: themeData
                                                .textTheme.titleLarge
                                                ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            user.email,
                                            style: themeData
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                              color: themeData
                                                  .colorScheme.onSurface
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: themeData
                                                  .colorScheme.secondary
                                                  .withOpacity(0.9),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              user.group['name'],
                                              style: themeData
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: themeData
                                                    .colorScheme.onSecondary,
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
                                            color:
                                                themeData.colorScheme.secondary,
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
                                            context
                                                .read<UserBloc>()
                                                .add(DeleteUser(user.id));
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
