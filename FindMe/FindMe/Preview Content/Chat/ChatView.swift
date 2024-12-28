//
//  ChatView.swift
//  FindMe
//
//  Created by deathot on 12/24/24.
//

import SwiftUI
import Combine

struct ChatView: View {
    
    @State var chatMessages: [ChatMessage] = []
    @State var messageText: String = ""
    @State var isLoading: Bool = false
    
    let openAIService = OpenAIService()
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(chatMessages, id: \.id) { message in
                            messageView(message: message)
                                .id(message.id)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Enter a message", text: $messageText) {
                    
                }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                
                Button {
                    sendMessage()
                } label: {
                    Text("Send ")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
//        onAppear {
//            print("ChatView appeared!")
//        }
    }
    
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .me { Spacer() }
            Text(message.content)
                .foregroundColor(message.sender == .me ? .white : .black)
                .padding()
                .background(message.sender == .me ? .blue : .gray.opacity(0.1))
                .cornerRadius(16)
            if message.sender == .gpt { Spacer() }
        }
    }
    
    func sendMessage() {
        
        guard !messageText.isEmpty else { return }
        
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me)
        
        chatMessages.append(myMessage)
        openAIService.sendMessage(message: messageText)
            .sink { completion in
            isLoading = false
            switch completion {
            case .finished:
                print("request complete")
            case .failure(let error):
                print("request failed with error: \(error.localizedDescription)")
            }
            // Handler error
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
            print("receive GPT message:\(textResponse)")
            
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .gpt)
            
            DispatchQueue.main.async {
                chatMessages.append(gptMessage)
            }
        }
        .store(in: &cancellables)
        messageText = ""
    }
    
}

struct ChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatView()
    }
}

struct ChatMessage {
    
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}

extension ChatMessage {
    
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Sample Message From me", dateCreated:  Date(), sender: .me),
        
        ChatMessage(id: UUID().uuidString, content: "Sample Message From gpt", dateCreated:  Date(), sender: .gpt),
        
        ChatMessage(id: UUID().uuidString, content: "Sample Message From me", dateCreated:  Date(), sender: .me),
        
        ChatMessage(id: UUID().uuidString, content: "Sample Message From gpt", dateCreated:  Date(), sender: .gpt)
    ]
}
