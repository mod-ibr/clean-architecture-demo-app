import 'package:clean_architecture_demo_app/Core/Utils/Functions/snackbar_message.dart';
import 'package:clean_architecture_demo_app/Core/Widgets/loading_widget.dart';
import 'package:clean_architecture_demo_app/Features/Postes/Domain/Entites/post_entity.dart';
import 'package:clean_architecture_demo_app/Features/Postes/presentation/view/postes_home_page.dart';
import 'package:clean_architecture_demo_app/Features/Postes/presentation/view_model/postes/postes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() =>
      AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<PostesBloc, PostesState>(
            listener: (context, state) {
              if (state is SucceededAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostesHomePage()),
                    (route) => false);
              } else if (state is ErrorPostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingPostState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}
