import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'im_rpc_platform_interface.dart';

/// An implementation of [ImRpcPlatform] that uses method channels.
class MethodChannelImRpc extends ImRpcPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('im_rpc');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
