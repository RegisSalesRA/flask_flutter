import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/application/pages/users/users_page.dart';
import 'package:client/injection.dart';
import 'package:client/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

import 'application/core/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: const MyApp(),
      )));
}

/**
 * void main() async {
  final client = http.Client();
  final userRemoteDatasource = UserRemoteDatasourceImpl(client: client);
  final userRepo = UserRepoImpl(userRemoteDatasource: userRemoteDatasource);
  final userUseCases = UserUseCases(userRepo: userRepo);
  final usersBloc = UserBloc(userUseCases: userUseCases);

  runApp(BlocProvider(
      create: (context) => usersBloc,
      child: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: const MyApp(),
      )));
}
 */

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: UserPageProvider(),
      );
    });
  }
}
