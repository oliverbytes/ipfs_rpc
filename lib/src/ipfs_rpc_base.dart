import 'api/api.dart' as api;
import 'api/ipfs_http_client.dart';

class IPFS {
  // SINGLETON
  static final IPFS _singleton = IPFS._internal();

  // FACTORY
  factory IPFS() => _singleton;

  // VARIABLES
  late IPFSClient client;

  // ROOT API
  late api.RootAPI root;
  // FILES API
  late api.FilesAPI files;

  // CONSTRUCTOR
  IPFS._internal() {
    client = IPFSClient();

    // ROOT API
    root = api.RootAPI();
    root.setClient(client);

    // FILES API
    files = api.FilesAPI();
    files.setClient(client);
  }
}
