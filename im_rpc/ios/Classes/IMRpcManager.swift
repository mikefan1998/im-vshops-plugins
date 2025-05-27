//
//  IMRpcManager.swift
//  im_rpc
//
//  Created by mike.fan on 2025/5/27.
//

import UIKit
import VGNetworkingAdapter
import Moya

public class IMRpcManager: HandyJsonGetFetch<VPBaseModel> {

    public override var path: String {
        get { return requestPath }
        set { requestPath = newValue }
    }

    public override var parameters: [String: Any]? {
        get { return bodyParams }
        set { bodyParams = newValue }
    }

    public override var method: Moya.Method {
        get { return methodType }
        set { methodType = newValue }
    }

    public override var task: Task {
        get { return requestWithJsonParameters(parameters: bodyParams ?? [:], isPost: methodType == .post, noBrackets: true) }
        set {}
    }
    
    // MARK: - Lifecycle
    
    
    // MARK: - LoadView
    
    
    // MARK: - Public
    
    
    // MARK: - private
    
    
    // MARK: - Action
    
    
    // MARK: - Delegate
    
    
    // MARK: - Request
    
    
    // MARK: - Notification
    
    
    // MARK: - setter/gettter
    /// 路径
    var requestPath: String = ""
    /// 请求类型 get post
    var methodType: Moya.Method = .get
    /// 请求参数
    var bodyParams: [String: Any]?
    
}


class IMRpcManagerCenter {
    
    // MARK: - Public
    
    private init() {}
    
    func add(_ manager: IMRpcManager, forKey key: String) {
        queue.async(flags: .barrier) {
            self.managers[key] = manager
        }
    }

    func remove(forKey key: String) {
        queue.async(flags: .barrier) {
            self.managers.removeValue(forKey: key)
        }
    }
    // MARK: - private
    
    // MARK: - Action
    
    // MARK: - Delegate
    
    // MARK: - Request
    
    // MARK: - Notification
    
    // MARK: - setter/gettter
    
    static let shared = IMRpcManagerCenter()
    
    private var managers: [String: IMRpcManager] = [:]
    private let queue = DispatchQueue(label: "com.imrpc.manager.center", attributes: .concurrent)

   
}
