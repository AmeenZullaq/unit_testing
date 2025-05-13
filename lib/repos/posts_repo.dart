import 'package:unit_testing/data_sources/remote_data_source.dart';
import 'package:unit_testing/models/post_model.dart';

abstract class PostsRepo {
  Future<List<PostModel>> getPosts();
}

class PostsRepoImpl extends PostsRepo {
  final RemoteDataSource remoteDataSource;

  PostsRepoImpl(this.remoteDataSource);

  @override
  Future<List<PostModel>> getPosts() async {
    final data = await remoteDataSource.getPosts();
    return data;
  }
}
