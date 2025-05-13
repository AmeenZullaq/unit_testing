import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/services/network_service.dart';
import 'package:unit_testing/data_sources/remote_data_source.dart';
import 'package:unit_testing/models/post_model.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks(
    [NetworkService]) // this line to create mock service likes NetworkService
/// run this : flutter pub run build_runner build --delete-conflicting-outputs
void main() {
  late RemoteDataSourceImpl remoteDataSource;
  late NetworkService mockNetworkService;

  setUp(() {
    //   // networkService =
    //   //     NetworkServiceImppl(); // we can not create networkService object because we do not want to use with real database , so we will use mockito
    mockNetworkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(mockNetworkService);
  });

  test(
    'Get posts from remote data source successfully',
    () async {
      /// arrange
      final posts = List.generate(
        5,
        (index) => PostModel(
          id: index,
          userId: index,
          title: 'title $index',
          body: 'body $index',
        ),
      );

      final postsMap = posts.map((post) => post.toJson()).toList();

      when(
        mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'),
      ).thenAnswer((_) => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: 'https://jsonplaceholder.typicode.com/posts',
              ),
              data: postsMap,
              statusCode: 200,
            ),
          ));

      /// act
      final result = await remoteDataSource.getPosts();

      /// assert
      expect(result, posts);
    },
  );

  test(
    'get posts from remote data source failed',
    () async {
      // arrange
      final expectedResult = throwsA(isA<Exception>());
      when(
        mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts',
            ),
          
          ),
        ),
      );
      // act
      final result = ()async => remoteDataSource.getPosts();

      // assert
      expect(result, expectedResult);
    },
  );
}
