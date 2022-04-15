import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';

import '../model/ipfs_error_response.model.dart';

class IPFSClient {
  // PROPERTIES
  String scheme;
  String host;
  int port;
  int apiVersion;
  bool verbose;
  int receiveTimeout;
  int sendTimeout;

  // CONSTRUCTOR
  IPFSClient({
    this.scheme = 'http',
    this.host = '127.0.0.1',
    this.port = 5001,
    this.apiVersion = 0,
    this.verbose = false,
    this.receiveTimeout = 20000,
    this.sendTimeout = 20000,
  });

  // GETTERS
  String get baseUrl => '$scheme://$host:$port';
  String get apiUrl => '$baseUrl/api/v$apiVersion';

  // VARIABLES
  final _dio = Dio();

  // FUNCTIONS
  void init({
    String scheme = 'http',
    String host = '127.0.0.1',
    int port = 5001,
    int apiVersion = 0,
    bool verbose = false,
    int receiveTimeout = 20000,
    int sendTimeout = 20000,
  }) {
    this.scheme = scheme;
    this.host = host;
    this.port = port;
    this.apiVersion = apiVersion;
    this.verbose = verbose;
    this.sendTimeout = sendTimeout;
  }

  Future<Either<IpfsErrorResponse, Response<dynamic>>> request(
    String endpoint, {
    Map<String, dynamic>? parameters,
    dynamic data,
    HTTPMethod method = HTTPMethod.post,
    String? savePath,
  }) async {
    if (verbose) {
      print(
          '${method.name.toUpperCase()}: $apiUrl/$endpoint, Params: $parameters, Data: $data');
    }

    try {
      String urlParams = '';

      if (parameters != null &&
          parameters.containsKey('source') &&
          parameters.containsKey('destination')) {
        urlParams =
            "?arg=${parameters['source']}&arg=${parameters['destination']}";
      }

      // remove null values
      // Because Dio's queryParameters doesn't support duplicate keys
      // we use a custom source & destination key pairs
      // then construct them manually in the url as query parameters
      parameters?.removeWhere(
        (key, value) =>
            value == null || key == 'source' || key == 'destination',
      );

      final options = Options(
        method: method.name.toUpperCase(),
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );

      Response<dynamic>? response;

      if (savePath == null) {
        response = await _dio.request(
          '$apiUrl/$endpoint$urlParams',
          data: data,
          queryParameters: parameters,
          options: options,
        );
      } else {
        response = await _dio.download(
          '$apiUrl/$endpoint$urlParams',
          savePath,
          data: data,
          queryParameters: parameters,
          options: options,
        );
      }

      if (verbose) {
        print(
            '${response.statusCode}: ${Uri.decodeFull(response.realUri.toString())}');
      }

      return Right(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(
          IpfsErrorResponse(
            code: 0,
            message: 'Null response: ${e.type}: ${e.message}',
            type: 'local',
          ),
        );
      }

      if (verbose) {
        print(
            '${e.response!.statusCode}: ${Uri.decodeFull(e.response!.realUri.toString())}, Data: ${e.response!.data}, Status Message: ${e.response!.statusMessage}');
      }

      if (e.response!.headers.value('Content-Type') == 'application/json') {
        return Left(IpfsErrorResponse.fromJson(e.response!.data));
      }

      // if error is not JSON
      return Left(
        IpfsErrorResponse(
          code: e.response!.statusCode!,
          message: e.response!.data,
          type: 'text/plain error',
        ),
      );
    } catch (e) {
      // different error
      return Left(
        IpfsErrorResponse(
          code: 0,
          message: 'Error: $e',
          type: 'unknown',
        ),
      );
    }
  }
}

enum HTTPMethod {
  get,
  post,
}
