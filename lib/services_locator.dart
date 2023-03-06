import 'package:clean_architecture_demo_app/Core/Network/network_connection_checker.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/DataSources/post_local_data_source.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/DataSources/post_remote_data_source.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Data/Repositories/postes_repository_impl.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Repositories/postes_repository.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/add_post_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/delete_post_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/get_all_postes_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/UseCases/update_post_use_case.dart';
import 'package:clean_architecture_demo_app/Features/Postes/presentation/view_model/postes/postes_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> servicesLocator() async {
  //! Features - posts

  // Bloc

  sl.registerFactory(() => PostesBloc(
      getAllPostsUseCase: sl(),
      addPostUseCase: sl(),
      updatePostUseCase: sl(),
      deletePostUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(postesRepository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(postesRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postesRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(postesRepository: sl()));

  // Repositories
  sl.registerLazySingleton<PostesRepository>(() => PostesRepositoryImpl(
      postLocalDataSource: sl(),
      postRemoteDataSource: sl(),
      networkConnectionChecker: sl()));

  // DataSources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceHttp(client: sl()));

  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceSharedPrefes(sl()));

  //! Core
  sl.registerLazySingleton<NetworkConnectionChecker>(
      () => NetworkConnectionCheckerImpl(sl()));

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
