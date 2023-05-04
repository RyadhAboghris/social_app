// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({
    @required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${userModel.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('${userModel.name}'),
              ]),
            ),
            body: SocialCubit.get(context).messages.length <= 0
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];

                              if (SocialCubit.get(context).userModel.uId ==
                                  message.senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                        messageController.clear();
                                  },
                                  child: Icon(
                                    Icons.send,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(model.text)),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(model.text)),
      );
}
