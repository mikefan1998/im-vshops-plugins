import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'im_rpc_method_channel.dart';

abstract class ImRpcPlatform extends PlatformInterface {
  /// Constructs a ImRpcPlatform.
  ImRpcPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImRpcPlatform _instance = MethodChannelImRpc();

  /// The default instance of [ImRpcPlatform] to use.
  ///
  /// Defaults to [MethodChannelImRpc].
  static ImRpcPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImRpcPlatform] when
  /// they register themselves.
  static set instance(ImRpcPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
