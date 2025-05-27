
import 'im_rpc_platform_interface.dart';

class ImRpc {
  Future<String?> getPlatformVersion() {
    return ImRpcPlatform.instance.getPlatformVersion();
  }
}
