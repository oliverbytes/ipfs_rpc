import 'package:either_option/either_option.dart';
import 'package:ipfs_rpc/src/api/ipfs_http_client.dart';

import '../model/ipfs_error_response.model.dart';

class RootAPI {
  late IPFSClient client;

  void setClient(IPFSClient client) {
    this.client = client;
  }

  // FUNCTIONS

  // GET
  Future<Either<IpfsErrorResponse, dynamic>> get({
    required String? arg,
    String? output,
    bool? archive,
    bool? compress,
    int? compressionLevel,
    String? savePath,
  }) async {
    final result = await client.request(
      'get',
      savePath: savePath,
      parameters: {
        'arg': arg,
        'output': output,
        'archive': archive,
        'compress': compress,
        'compression-level': compressionLevel,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // CAT
  Future<Either<IpfsErrorResponse, dynamic>> cat({
    required String? arg,
    int? offset,
    int? length,
    String? savePath,
  }) async {
    final result = await client.request(
      'cat',
      savePath: savePath,
      parameters: {
        'arg': arg,
        'offset': offset,
        'length': length,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }
}
