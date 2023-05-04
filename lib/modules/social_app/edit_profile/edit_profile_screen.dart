import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/componenets.dart';

class EditProfileScreen extends StatelessWidget {
  var nameConttroller = TextEditingController();
  var phoneConttroller = TextEditingController();
  var bioConttroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameConttroller.text = userModel.name;
        phoneConttroller.text = userModel.phone;
        bioConttroller.text = userModel.bio;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: ' Edit Profile', actions: [
            defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUserImages(
                      name: nameConttroller.text,
                      phone: phoneConttroller.text,
                      bio: bioConttroller.text);
                },
                text: 'Upadte'),
            SizedBox(
              width: 15,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage('${userModel.cover}')
                                      : FileImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getCoverImage();
                              },
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel.image}')
                                  : FileImage(profileImage),
                            ),
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 16,
                              ),
                            ),
                            onPressed: () {
                              SocialCubit.get(context).getProfileImage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: state is SocialUserUpdateLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameConttroller.text,
                                        phone: phoneConttroller.text,
                                        bio: bioConttroller.text);
                                  },
                                  text: 'Upload profile '),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: state is SocialUserUpdateLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameConttroller.text,
                                        phone: phoneConttroller.text,
                                        bio: bioConttroller.text);
                                  },
                                  text: 'Upload cover '),
                        ),
                    ],
                  ),
                if (SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null)
                  SizedBox(
                    height: 20,
                  ),
                defaultformfield(
                  conttroller: nameConttroller,
                  type: TextInputType.name,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  lable: 'Name',
                  prefx: Icons.people_outline,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultformfield(
                  conttroller: bioConttroller,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'bio must not be empty';
                    }
                    return null;
                  },
                  lable: 'Bio',
                  prefx: Icons.info_outline,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultformfield(
                  conttroller: phoneConttroller,
                  type: TextInputType.name,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'phone number must not be empty';
                    }
                    return null;
                  },
                  lable: 'Phone',
                  prefx: Icons.call,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
