import 'package:client/application/pages/groups/bloc/group_bloc.dart';
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider<GroupBloc>(
          create: (context) => sl<GroupBloc>(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: UserPage(),
    );
  }
}
