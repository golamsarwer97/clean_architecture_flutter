import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './core/theme/app_theme.dart';
import './features/auth/presentation/screens/sign_in.dart';
import './init_dependencies.dart';
import './features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SignInPage(),
    );
  }
}
