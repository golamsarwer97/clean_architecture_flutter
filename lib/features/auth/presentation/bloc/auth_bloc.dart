// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domin/usecases/current_user_usecase.dart';
import '../../domin/usecases/user_sign_up_usecase.dart';
import '../../domin/usecases/user_sign_in_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignUpUsecase;
  final UserSignInUsecase _userSignInUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase,
    required UserSignInUsecase userSignInUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUpUsecase = userSignUpUsecase,
        _userSignInUsecase = userSignInUsecase,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUserUsecase(NoParams());

    res.fold(
      (failure) => {
        print('usersssssssssss failure '),
        emit(AuthFailure(message: failure.message))
      },
      (user) {
        print('usersssssssssss');
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUpUsecase.call(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignInUsecase.call(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSucess(user: user));
  }
}
