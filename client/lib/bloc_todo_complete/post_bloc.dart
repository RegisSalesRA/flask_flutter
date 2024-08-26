import 'package:client/bloc_todo_complete/post_bloc_event.dart';
import 'package:client/bloc_todo_complete/post_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError("Failed to fetch posts"));
      }
    });

    on<AddPost>((event, emit) async {
      try {
        await repository.addPost(event.post);
        add(LoadPosts());
      } catch (e) {
        emit(PostError("Failed to add post"));
      }
    });

    on<UpdatePost>((event, emit) async {
      try {
        await repository.updatePost(event.post);
        add(LoadPosts());
      } catch (e) {
        emit(PostError("Failed to update post"));
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        await repository.deletePost(event.id);
        add(LoadPosts());
      } catch (e) {
        emit(PostError("Failed to delete post"));
      }
    });
  }
}
