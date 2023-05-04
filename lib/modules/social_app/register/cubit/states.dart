






import 'cubit.dart';

abstract class SocialRegisterStates  {}

class SocialRegisterInitalState extends SocialRegisterStates{}

class SocialRegisterLodingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {

}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialRegisterCahngePasswordVisibilityState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;
  SocialCreateUserErrorState(this.error);
}
