import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/user.dart';
import '../../domin/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignUpUsecase;

  AuthBloc({required UserSignUpUsecase userSignUpUsecase})
      : _userSignUpUsecase = userSignUpUsecase,
        super(AuthInitial()) {
    on<AuthSignUp>(
      (event, emit) async {
        emit(AuthLoading());
        final res = await _userSignUpUsecase.call(
          UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );

        res.fold(
          (failure) => emit(AuthFailure(message: failure.message)),
          (user) => emit(AuthSucess(user: user)),
        );
      },
    );
  }
}
