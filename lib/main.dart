import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './core/theme/app_theme.dart';
import './features/auth/presentation/screens/sign_in.dart';
import './init_dependencies.dart';
import './features/auth/presentation/bloc/auth_bloc.dart';
import './common/cubits/app_user/app_user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(
                child: Text('Logged In'),
              ),
            );
          }
          return const SignInPage();
        },
      ),
    );
  }
}
