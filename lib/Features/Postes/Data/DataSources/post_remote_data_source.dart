import 'dart:convert';

import 'package:clean_architecture_demo_app/Core/Errors/exception.dart';
import 'package:clean_architecture_demo_app/Core/Utils/Constants/post_constants.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/Models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPostes();
  Future<Unit> deletePost(int postId);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePoste(PostModel postModel);
}

class PostRemoteDataSourceHttp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPostes() async {
    const String allPostsURL = '${PostConstants.kPostesBaseURL}/posts';
    final response = await client.get(
      Uri.parse(allPostsURL),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List<dynamic> decodedPostes = json.decode(response.body);

      final List<PostModel> allPostes = decodedPostes
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
      return allPostes;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      PostConstants.kTitle: postModel.title,
      PostConstants.kBody: postModel.body
    };
    const addPostURL = '${PostConstants.kPostesBaseURL}/posts';
    final response = await client.post(Uri.parse(addPostURL), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    String deletePostURL =
        '${PostConstants.kPostesBaseURL}/posts/${postId.toString()}';
    final response = await client.delete(Uri.parse(deletePostURL));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePoste(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      PostConstants.kTitle: postModel.title,
      PostConstants.kBody: postModel.body
    };
    String updatePostURL = '${PostConstants.kPostesBaseURL}/posts/$postId';
    final response = await client.patch(Uri.parse(updatePostURL), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
