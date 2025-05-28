import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'im_rpc_platform_interface.dart';

/// An implementation of [ImRpcPlatform] that uses method channels.
class MethodChannelImRpc extends ImRpcPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('im_rpc');

  /// Makes a request to the Imiracle RPC server, using the method channel.
  ///
  /// [path] is the path of the RPC endpoint.
  ///
  /// [method] is the RPC method to call.
  ///
  /// [body] are the arguments to pass to the RPC endpoint.
  ///
  /// Returns the response from the RPC endpoint as a string, or null if
  /// there was an error.
  ///
  /// The method channel is used to make the request. If the request fails,
  /// the error is printed to the console.
  static Future<String?> request(String path, String method,
      {Map<String, String> body = const {}}) async {
    try {
      final result = await methodChannel.invokeMethod(
          'request', {'path': path, 'method': method, 'body': body});
      return result as String?;
    } on PlatformException catch (e) {
      print("调用请求失败: ${e.message}");
      return null;
    }
  }
}
