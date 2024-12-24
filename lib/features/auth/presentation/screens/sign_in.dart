import 'package:bloc_getit_hive/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/showsnack_bar.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../core/theme/app_palette.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/auth_input.dart';
import 'sign_up.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const SignInPage(),
      );
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  // final TextEditingController emailTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    // emailTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showsnackbar(context: context, content: state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    /*AuthInput(
                            hintText: 'Name',
                            controller: emailTextController,
                          ),
                          const SizedBox(height: 15),*/
                    AuthInput(
                      hintText: 'Email',
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    AuthInput(
                      hintText: 'Password',
                      controller: passwordTextController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 25),
                    AuthGradientButton(
                      buttonText: 'Sign In',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignIn(
                                  email: emailTextController.text.trim(),
                                  password: passwordTextController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          SignUpPage.route(),
                          // (Route<dynamic> route) => false,
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppPalette.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
