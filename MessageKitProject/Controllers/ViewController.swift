//
//  ViewController.swift
//  MessageKitProject
//
//  Created by yonekan on 2019/12/02.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
// MessageKitというライブラリを使えるように読み込む
import MessageKit
// 送信ボタンを使えるように読み込む
import InputBarAccessoryView

// MessagesViewController: チャット画面を作成してくれるコントローラー
class ViewController: MessagesViewController {

    // 全メッセージを持つ配列
    var messageList: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }
    
    // 送信された文字に応じて、返信のメッセージを作成するメソッド
    // text: 送信された文字
    func createResponse(text: String) -> Message {
        
        // 返信用の送信者の作成
        let user = ChatUser(senderId: "9999", displayName: "Bot")
        
        // 返信を作成
        if text == "こんにちは" {
            return Message(
                user: user,
                text: "Hello",
                messageId: UUID().uuidString,
                sentDate: Date())
        } else if text == "Hello" {
            return Message(
            user: user,
            text: "How r u ?",
            messageId: UUID().uuidString,
            sentDate: Date())
        }
        
        return Message(
            user: user,
            text: "よくわかりません",
            messageId: UUID().uuidString,
            sentDate: Date())
    }
    
}

// メッセージの設定
// - 自分の設定
// - 何件表示するか
// - メッセージ本文の設定
extension ViewController: MessagesDataSource {
    // 自分の情報を設定
    func currentSender() -> SenderType {
        let id = "12345"
        let name = "SeedKun"
        return ChatUser(senderId: id, displayName: name)
    }
    
    // 各メッセージの情報を設定する
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messageList[indexPath.section]
        
    }
    
    // メッセージの件数を設定する
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
}

// メッセージ入力欄や送信ボタンの設定
extension ViewController: InputBarAccessoryViewDelegate {
    
    // 送信ボタンがクリックされた時の処理
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        // 新規メッセージを作成
        // 自分の情報を取得 self.currentSender()：でログイン者が取得できる
        let me = self.currentSender() as! ChatUser
        
        let newMessage = Message(
                user: me,
                text: text,
                messageId: UUID().uuidString, // 絶対にかぶらないIDを生成
                sentDate: Date() // 現在時刻
        )
        
        // 配列に追加
        messageList.append(newMessage)
        
        // 画面に新しいメッセージを表示する
        messagesCollectionView.insertSections([messageList.count - 1])
        
        // 入力バーの入力値をリセット
        inputBar.inputTextView.text = ""
        
        // 返信のメッセージを作成
        let responseMessage = createResponse(text: text)
        
        // 返信のメッセージを配列に追加
        messageList.append(responseMessage)
        
        // 返信のメッセージを画面に表示
        messagesCollectionView.insertSections([messageList.count - 1])
        
    }
    
}

extension ViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        if isFromCurrentSender(message: message) {
            // このメッセージの送信者が自分の場合
            return .red
        } else {
            // このメッセージの送信者が自分以外の場合
            return .blue
        }
        
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        if isFromCurrentSender(message: message) {
          // このメッセージの送信者が自分の場合
            return .black
        } else {
            // このメッセージの送信者が自分以外の場合
            return .white
        }
        
    }
    
}

extension ViewController: MessagesLayoutDelegate {
    
}
