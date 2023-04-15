import 'package:clean_architecture_demo_app/Core/Widgets/loading_widget.dart';
import 'package:clean_architecture_demo_app/Features/Postes/presentation/view_model/postes/postes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/posts_page/message_display_widget.dart';
import '../widgets/posts_page/post_list_widget.dart';
import 'post_add_update_page.dart';

class PostesHomePage extends StatefulWidget {
  const PostesHomePage({super.key});

  @override
  State<PostesHomePage> createState() => _PostesHomePageState();
}

class _PostesHomePageState extends State<PostesHomePage> {
  @override
  void initState() {
    BlocProvider.of<PostesBloc>(context).add(GetAllPostesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context: context),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Postes Home Page'));

  Widget _buildBody({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<PostesBloc, PostesState>(
          builder: (context, state) {
            if (state is LoadingPostState) {
              return const LoadingWidget();
            } else if (state is SucceededLoadedPostState) {
              return PostListWidget(posts: state.posts);
            } else if (state is ErrorPostState) {
              return MessageDisplayWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostesBloc>(context).add(RefreshPostesEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(
                      isUpdatePost: false,
                    )));
      },
      child: const Icon(Icons.add),
    );
  }
}
