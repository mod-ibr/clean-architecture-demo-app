import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:flutter/material.dart';

import '../../view/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final PostEntity postEntity;
  const UpdatePostBtnWidget({
    Key? key,
    required this.postEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdatePost: true,
                post: postEntity,
              ),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
