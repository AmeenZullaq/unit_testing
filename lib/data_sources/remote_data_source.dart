import 'package:dio/dio.dart';
import 'package:unit_testing/core/services/network_service.dart';
import 'package:unit_testing/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;

  RemoteDataSourceImpl(this.networkService);
  @override
  Future<List<PostModel>> getPosts() async {
    Response response =
        await networkService.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final result = response.data as List;

    final posts = result.map((e) => PostModel.fromJson(e)).toList();

    return posts;
  }
}
