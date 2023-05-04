import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/components/componenets.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/styles/colors.dart';
import '../chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.length < 0
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length);
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
}
