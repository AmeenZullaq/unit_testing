import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
}
