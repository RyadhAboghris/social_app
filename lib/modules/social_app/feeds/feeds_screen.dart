import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/componenets.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return SocialCubit.get(context).posts.length < 0 &&
                SocialCubit.get(context).userModel == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-vector/back-school-accessories-composition-poster_1284-9693.jpg?w=996&t=st=1662354113~exp=1662354713~hmac=6da96bfd3ed6da2793fc1520c19f600ca35fb43a7819bda950103371e458c229'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildPostItem(cubit.posts[index], context, index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                      itemCount: cubit.posts.length,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dataTime}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6,
                      ),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: defaultColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6,
                      ),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: defaultColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.chat,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel.image}',
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Write a comment ...',
                            style:
                                Theme.of(context).textTheme.caption.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
