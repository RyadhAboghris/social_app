






abstract class SocialLoginStates  {}

class SocialLoginInitalState extends SocialLoginStates{}

class SocialLoginLodingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
final String uId;

  SocialLoginSuccessState(this.uId);
  
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialCahngePasswordVisibilityState extends SocialLoginStates {}
