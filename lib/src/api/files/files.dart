import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:ipfs_rpc/src/api/ipfs_http_client.dart';

import '../../model/files/flush/files_flush_response.model.dart';
import '../../model/ipfs_error_response.model.dart';
import '../../model/files/ls/files_ls_response.model.dart';
import '../../model/files/stat/files_stat_response.model.dart';

class FilesAPI {
  late IPFSClient client;

  void setClient(IPFSClient client) {
    this.client = client;
  }

  // FUNCTIONS

  // CHANGE CID
  Future<Either<IpfsErrorResponse, String>> chcid({
    String? arg,
    int? cidVersion,
    String? hash,
  }) async {
    final result = await client.request(
      'files/chcid',
      parameters: {
        'arg': arg,
        'cid-version': cidVersion,
        'hash': hash,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // COPY
  Future<Either<IpfsErrorResponse, String>> cp({
    required String source,
    required String destination,
    bool? parents,
  }) async {
    final result = await client.request(
      'files/cp',
      parameters: {
        'source': source,
        'destination': destination,
        'parents': parents,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // FLUSH
  Future<Either<IpfsErrorResponse, FilesFlushResponse>> flush({
    String? arg,
  }) async {
    final result = await client.request(
      'files/flush',
      parameters: {
        'arg': arg,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(FilesFlushResponse.fromJson(response.data)),
    );
  }

  // LIST FILES
  Future<Either<IpfsErrorResponse, FilesLsResponse>> ls({
    String? arg,
    bool? long,
    bool? u,
  }) async {
    final result = await client.request(
      'files/ls',
      parameters: {
        'arg': arg,
        'long': long,
        'U': u,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(FilesLsResponse.fromJson(response.data)),
    );
  }

  // MAKE DIRECTORY
  Future<Either<IpfsErrorResponse, String>> mkdir({
    required String arg,
    bool? parents,
    int? cidVersion,
    String? hash,
  }) async {
    final result = await client.request(
      'files/mkdir',
      parameters: {
        'arg': arg,
        'parents': parents,
        'cid-version': cidVersion,
        'hash': hash,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // MAKE FILE
  Future<Either<IpfsErrorResponse, String>> mv({
    required String source,
    required String destination,
  }) async {
    final result = await client.request(
      'files/mv',
      parameters: {
        'source': source,
        'destination': destination,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // READ
  Future<Either<IpfsErrorResponse, String>> read({
    required String arg,
    int? offset,
    int? count,
  }) async {
    final result = await client.request(
      'files/read',
      parameters: {
        'arg': arg,
        'offset': offset,
        'count': count,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // READ
  Future<Either<IpfsErrorResponse, String>> rm({
    required String arg,
    bool? recursive,
    bool? force,
  }) async {
    final result = await client.request(
      'files/rm',
      parameters: {
        'arg': arg,
        'recursive': recursive,
        'force': force,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }

  // STATUS
  Future<Either<IpfsErrorResponse, FilesStatResponse>> stat({
    required String arg,
    String? format,
    bool? hash,
    bool? size,
    bool? withLocal,
  }) async {
    final result = await client.request(
      'files/stat',
      parameters: {
        'arg': arg,
        'format': format,
        'hash': hash,
        'size': size,
        'with-local': withLocal,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(FilesStatResponse.fromJson(response.data)),
    );
  }

  // WRITE
  Future<Either<IpfsErrorResponse, String>> write({
    required String arg,
    required String filePath,
    required String fileName,
    int? offset,
    bool? create,
    bool? parents,
    bool? truncate,
    int? count,
    bool? rawLeaves,
    int? cidVersion,
    String? hash,
  }) async {
    final formData = FormData.fromMap({
      'data': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    final result = await client.request(
      'files/write',
      data: formData,
      parameters: {
        'arg': arg,
        'offset': offset,
        'create': create,
        'parents': parents,
        'truncate': truncate,
        'count': count,
        'rawLeaves': rawLeaves,
        'cidVersion': cidVersion,
      },
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.data),
    );
  }
}
