//
//  network.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import Foundation
import Moya


let pageApiUrl = "http://8.212.151.134:10493"

let baseurl = pageApiUrl + "/credi" + "botapi"

let baseCommonUrl = "y.my.a"

enum MyService {
    case getData(endpoint: String, parameters: [String: Any]?)
    case postData(endpoint: String, parameters: [String: Any])
    case uploadImage(endpoint: String, imageData: Data?, parameters: [String: Any])
    case downloadImage(path: String)
}

extension MyService: TargetType {
    var baseURL: URL {
        let commonDict = CommonParameter().toDictionary()
        let apiUrl = URLParameterHelper.appendQueryParameters(to: baseurl, parameters: commonDict)!
        return URL(string: apiUrl)!
    }
    
    var path: String {
        switch self {
        case .getData(let endpoint, _),
                .postData(let endpoint, _),
                .uploadImage(let endpoint, _, _):
            return endpoint
        case .downloadImage(let path):
            return path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getData, .downloadImage:
            return .get
        case .postData, .uploadImage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getData(_, let parameters):
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
            
        case .postData(_, let parameters):
            let formData = parameters.map { key, value in
                MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key)
            }
            return .uploadMultipart(formData)
            
        case .uploadImage(_, let imageData, let parameters):
            guard let imageData = imageData else {
                return .requestPlain
            }

            var multipartData: [MultipartFormData] = []

            let imageFormData = MultipartFormData(
                provider: .data(imageData),
                name: "fairs",
                fileName: "fairs.jpg",
                mimeType: "image/jpeg"
            )
            multipartData.append(imageFormData)

            for (key, value) in parameters {
                let valueString = "\(value)"
                if let data = valueString.data(using: .utf8) {
                    let formData = MultipartFormData(provider: .data(data), name: key)
                    multipartData.append(formData)
                }
            }

            return .uploadMultipart(multipartData)

            
        case .downloadImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImage:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}


final class NetworkManager {
    
    private var provider = MoyaProvider<MyService>()
    
    init(provider: MoyaProvider<MyService> = MoyaProvider<MyService>()) {
        self.provider = provider
    }
    
    func request<T: Decodable>(_ target: MyService, responseType: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    if T.self == Data.self, let data = response.data as? T {
                        continuation.resume(returning: data)
                        return
                    }
                    
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: response.data)
                        continuation.resume(returning: decoded)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
