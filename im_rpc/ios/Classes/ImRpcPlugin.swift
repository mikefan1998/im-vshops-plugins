import Flutter
import VGNetworkingAdapter
import UIKit
import HandyJSON



public class ImRpcPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "im_rpc", binaryMessenger: registrar.messenger())
        let instance = ImRpcPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "request",
            let args = call.arguments as? [String: Any],
            let method = args["method"] as? String,
            let path = args["path"] as? String,
            let body = args["body"] as? [String: Any] {
            let rpcManager = IMRpcManager()
            rpcManager.requestPath = path
            rpcManager.bodyParams = body
            // 2. 完整处理HTTP方法
            switch method.uppercased() {
            case "POST":
                rpcManager.methodType = .post
            case "GET":
                rpcManager.methodType = .get
            case "PUT":
                rpcManager.methodType = .put
            case "DELETE":
                rpcManager.methodType = .delete
            default:
                rpcManager.methodType = .get
            }
            let key = UUID().uuidString
            IMRpcManagerCenter.shared.add(rpcManager, forKey: key)
            rpcManager.success { parameters in
                defer {
                    IMRpcManagerCenter.shared.remove(forKey: key)
                }
                var responseDict: [String: Any] = [:]
                responseDict["code"] = parameters?.toJSONString()
                responseDict["data"] = parameters?.data
                responseDict["msg"] = parameters?.msg
                result(parameters?.toJSONString())
            }.failure { parameters in
                defer {
                    IMRpcManagerCenter.shared.remove(forKey: key)
                }
                let model = HandyJsonResponseTemplate()
                model.code = -1001
                model.msg = parameters?.msg
                result(model.toJSONString())
            }.fetch()
        }else{
            result(FlutterMethodNotImplemented)
        }
    }
    
}
