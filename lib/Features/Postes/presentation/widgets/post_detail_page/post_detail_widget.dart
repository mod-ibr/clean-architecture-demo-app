import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';

import 'update_post_btn_widget.dart';
import 'package:flutter/material.dart';
import 'delete_post_btn_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final PostEntity postEntity;
  const PostDetailWidget({
    Key? key,
    required this.postEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            postEntity.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            postEntity.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(postEntity: postEntity),
              DeletePostBtnWidget(postId: postEntity.id!)
            ],
          )
        ],
      ),
    );
  }
}
