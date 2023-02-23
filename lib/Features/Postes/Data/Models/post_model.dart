import 'package:clean_architecture_demo_app/Core/Utils/Constants/post_constants.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';

class PostModel extends Post {
  const PostModel({int? id, required String title, required String body})
      : super(id: id, body: body, title: title);

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
        title: map[PostConstants.kTitle],
        body: map[PostConstants.kBody],
        id: map[PostConstants.kId]);
  }

  Map<String, dynamic> toJson() {
    return {
      PostConstants.kId: id,
      PostConstants.kTitle: title,
      PostConstants.kBody: body
    };
  }
}
