//
//  ChatUser.swift
//  MessageKitProject
//
//  Created by yonekan on 2019/12/02.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import MessageKit

// チャットのユーザー情報の設計図
class ChatUser: SenderType {
    // ID
    var senderId: String
    
    // 表示名
    var displayName: String
    
    /// イニシャライザー
    /// - Parameter senderId: ユーザーID
    /// - Parameter displayName: 表示名
    init(senderId: String, displayName: String) {
        
        self.senderId = senderId
        self.displayName = displayName
        
    }
}
