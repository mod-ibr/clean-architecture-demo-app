import 'dart:convert';

import 'package:clean_architecture_demo_app/Core/Errors/exception.dart';
import 'package:clean_architecture_demo_app/Core/Utils/Constants/post_constants.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/Models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePost(List<PostModel> postesmodels);
}

class PostLocalDataSourceSharedPrefes implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceSharedPrefes(this.sharedPreferences);

  @override
  Future<Unit> cachePost(List<PostModel> postesmodels) async {
    List<Map<String, dynamic>> postModelToJson = postesmodels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    await sharedPreferences.setString(
        PostConstants.kCachedPostes, json.encode(postModelToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(PostConstants.kCachedPostes);
    if (jsonString != null) {
      List<Map<String, dynamic>> jsonToList =
          json.encode(jsonString) as List<Map<String, dynamic>>;

      List<PostModel> allCachedPostes = jsonToList
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();

      return Future.value(allCachedPostes);
    } else {
      throw EmptyCacheException();
    }
  }
}
