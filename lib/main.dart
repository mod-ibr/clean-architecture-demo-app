import 'package:clean_architecture_demo_app/Features/Postes/presentation/view_model/postes/postes_bloc.dart';
import 'package:clean_architecture_demo_app/services_locator.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Postes/presentation/view/postes_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.servicesLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostesBloc>(create: (_) => di.sl<PostesBloc>()
              // ..add(
              //   GetAllPostesEvent(),
              // ),
              ),
        ],
        child: const MaterialApp(
          title: 'Flutter Clean Architecture Demo App',
          home: PostesHomePage(),
        ));
  }
}
