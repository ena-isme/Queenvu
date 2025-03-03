//
//  DummyFriends.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

struct DummyFriend {
    let name: String
    let email: String
    let heart: Int
}

func createDummyFriends() -> [DummyFriend] {
    return [
        DummyFriend(name: "뀨", email: "alice@naver.com", heart: 1),
        DummyFriend(name: "밥밥",email: "bob@gmail.com", heart: 2),
        DummyFriend(name: "해삐",email: "charlie@egmail.com", heart: 1),
        DummyFriend(name: "밍",email: "david@gmail.com", heart: 1),
        DummyFriend(name: "먕",email: "jiwon@naver.com", heart: 5),
        DummyFriend(name: "에바여",email: "eve@naver.com", heart: 7),
        DummyFriend(name: "ㅋㅋ리얼~",email: "shin@gmail.com", heart: 5),
        DummyFriend(name: "메롱",email: "eve@gmail.com", heart: 4)
    ]
}
