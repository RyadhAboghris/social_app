import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';

import '../../../shared/components/componenets.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
                function: () {
                  var now = DateTime.now().toString();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context)
                        .createPost(dataTime: now, text: textController.text);
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                        dataTime: now, text: textController.text);
                  }
                },
                text: 'Post'),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/chalkboard-back-school-background_23-2148208578.jpg?w=1060&t=st=1662355023~exp=1662355623~hmac=b15e60ed1261dc109b7e1f6c7c4274e81c928b04d2dd4560e37347c91a928ef5',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Ryadh Aboghris',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('#tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
