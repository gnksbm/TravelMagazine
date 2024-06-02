//
//  ChattingModel.swift
//
//  Created by Den on 2024/05/11.
//

import Foundation

//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    let message: String
}

extension Chat {
    var visibleDate: String? {
        let date = date.formatted(dateFormat: .chatInput)
        return date?.formatted(dateFormat: .cellOutput)
    }
}

extension Array where Element == Chat {
    private var toDateDic: [String: Self] {
        var dic = [String: Self]()
        forEach { chat in
            if let date = chat.date.formatted(dateFormat: .chatInput) {
                dic[
                    date.formatted(dateFormat: .magazineOutput),
                    default: [Chat]()
                ].append(chat)
            }
        }
        return dic
    }
    
    var toSectionModel: [ChatSection] {
        toDateDic.map { key, value in
            ChatSection(date: key, chatList: value)
        }
        .sorted(by: { $0.date < $1.date })
    }
}

struct ChatSection {
    let date: String
    var chatList: [Chat]
}

extension Array where Element == ChatSection {
    subscript(indexPath indexPath: IndexPath) -> Chat {
        self[indexPath.section].chatList[indexPath.row]
    }
}
