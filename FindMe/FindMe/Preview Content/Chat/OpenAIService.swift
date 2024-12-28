//
//  OpenAIService.swift
//  FindMe
//
//  Created by deathot on 12/24/24.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    
    let baseUrl = "https://api.openai.com/v1/chat/"
    
    func sendMessage(message: String) -> AnyPublisher<OpenAICompletionsResponse, Error> {
            let body = OpenAIChatBody(
                model: "gpt-4",
                messages: [
                    OpenAIMessage(role: "user", content: message)
                ],
                temperature: 0.7,
                max_tokens: 256
            )
        
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Constants.openAIAPIKey)"
            ]
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            AF.request(self.baseUrl + "completions", method: .post, parameters: body, encoder: .json, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print("API Response:", value)  // 打印返回的原始 JSON 数据
                    case .failure(let error):
                        print("Request failed:", error)  // 打印请求失败的错误
                    }
                }
            
            AF.request(self.baseUrl + "completions", method: .post, parameters: body, encoder: .json, headers: headers).responseDecodable(of: OpenAICompletionsResponse.self)
                { response in
                        switch response.result {
                        case .success(let result):
                            print("API success:", result)
                            promise(.success(result))
                        case .failure(let error):
                            print("API fail", error)
                            promise(.failure(error))
                        }
                }
        }
        .eraseToAnyPublisher()
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIMessage]
    let temperature: Float?
    let max_tokens: Int?
}

struct OpenAICompletionsResponse: Decodable {
    let id: String
    let choices: [OpenAICompletionsChoice]
}

struct OpenAICompletionsChoice: Decodable {
    let message: OpenAIMessage
}

struct OpenAIMessage: Codable {
    let role: String
    let content: String
}
