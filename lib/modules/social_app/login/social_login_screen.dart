import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/componenets.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, SocialLoginStates state) {
          if (state is SocialLoginSuccessState) {}

          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
                 CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(context, SocialLayout());
              showToast(
                  text:'تم تسجيل الدخول بنجاح', state: ToastStates.SUCCESS);
            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'login now to comunicate with freinds',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          defaultformfield(
                            conttroller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your email adderss';
                              }
                            },
                            lable: 'Email Address',
                            prefx: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultformfield(
                            conttroller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            onSubmit: (_) {
                              if (formKey.currentState.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffixPressed: (_) {
                              print('ok');
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            lable: 'Password',
                            prefx: Icons.lock_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: state is! SocialLoginLodingState
                                  ? RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          SocialLoginCubit.get(context)
                                              .userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                        }
                                      },
                                      child: Text('LOGIN'),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                function: () =>
                                    navigateTo(context, SocialRegisterScreen()),
                                text: 'registry',
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
