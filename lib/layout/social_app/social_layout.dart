import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/modules/social_app/new_post/new_post_screen.dart';

import '../../shared/components/componenets.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(icon: Icon(Icons.notifications)),
              IconButton(icon: Icon(Icons.search)),
            ],
          ),
          body: 
          model == null
              ? Center(child: CircularProgressIndicator())
              : cubit.screens[cubit.currentIndex],
          // if (!FirebaseAuth.instance.currentUser.emailVerified)
          // Container(
          //   color: Colors.amber.withOpacity(.6),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: Row(
          //       children: [
          //         Icon(Icons.info_outline),
          //         SizedBox(
          //           width: 15,
          //         ),
          //         Expanded(child: Text('please verfy your email')),
          //         SizedBox(
          //           width: 15,
          //         ),
          //         defaultTextButton(
          //           function: () {
          //             FirebaseAuth.instance.currentUser
          //                 .sendEmailVerification()
          //                 .then((value) {
          //               showToast(
          //                   text: 'check your mail',
          //                   state: ToastStates.SUCCESS);
          //             }).catchError((error) {});
          //           },
          //           text: 'send',
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.chanageBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(
                      Icons.home,
                    )),
                BottomNavigationBarItem(
                    label: 'Chats',
                    icon: Icon(
                      Icons.chat,
                    )),
                BottomNavigationBarItem(
                    label: 'Post',
                    icon: Icon(
                      Icons.post_add,
                    )),
                BottomNavigationBarItem(
                    label: 'Users',
                    icon: Icon(
                      Icons.people,
                    )),
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Icon(
                      Icons.settings,
                    )),
              ]),
        );
      },
    );
  }
}
