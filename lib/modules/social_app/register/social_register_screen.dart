import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/componenets.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }

          if (state is SocialRegisterErrorState) {
            showToast(text: 'يوجد هناك خطأ ما', state: ToastStates.ERROR);
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
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'register now to comunicate with freinds',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          defaultformfield(
                            conttroller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            lable: 'User Name',
                            prefx: Icons.person,
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
                            suffix: SocialRegisterCubit.get(context).suffix,
                            onSubmit: (_) {},
                            isPassword:
                                SocialRegisterCubit.get(context).isPassword,
                            suffixPressed: (_) {
                              print('ok');
                              SocialRegisterCubit.get(context)
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
                          defaultformfield(
                            conttroller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            lable: 'Phone',
                            prefx: Icons.phone,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: state is! SocialRegisterLodingState
                                  ? RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          SocialRegisterCubit.get(context)
                                              .userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      child: Text('REGISTER'),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
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
