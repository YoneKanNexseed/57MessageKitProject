//
//  Message.swift
//  MessageKitProject
//
//  Created by yonekan on 2019/12/02.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import MessageKit

class Message {
    
    // このメッセージの送信者
    let user: ChatUser
    
    // 本文
    let text: String
    
    // メッセージID
    let messageId: String
    
    // 送信日付
    let sentDate: Date
    
    
    /// イニシャライザー
    /// - Parameter user: メッセージ送信者
    /// - Parameter text: メッセージ本文
    /// - Parameter messageId: メッセージID
    /// - Parameter sentDate: 送信日付
    init(
        user: ChatUser,
        text: String,
        messageId: String,
        sentDate: Date
    ) {
        self.user = user
        self.text = text
        self.messageId = messageId
        self.sentDate = sentDate
    }
}

extension Message: MessageType {
    
    // メッセージの送信者を返す
    var sender: SenderType {
        return Sender(senderId: user.senderId, displayName: user.displayName)
    }
    
    // メッセージのタイプを返す
    // 今回はテキストのみだが、画像やロケーションなども設定できる
    var kind: MessageKind {
        return .text(text)
    }
    
}
