import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/data_sources/remote_data_source.dart';
import 'package:unit_testing/models/post_model.dart';
import 'package:unit_testing/repos/posts_repo.dart';

import 'repo_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late PostsRepo postsRepo;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    postsRepo = PostsRepoImpl(remoteDataSource);
  });
  test(
    'get posts from repo impl successfully',
    () async {
      // arrange
      List<PostModel> posts = List.generate(
        5,
        (index) => PostModel(
          id: index,
          userId: index,
          title: 'title $index',
          body: 'body $index',
        ),
      );
      when(remoteDataSource.getPosts()).thenAnswer(
        (_) => Future.value(
          posts,
        ),
      );
      // act
      final result = await postsRepo.getPosts();

      // assert
      expect(result, posts);
    },
  );
}
