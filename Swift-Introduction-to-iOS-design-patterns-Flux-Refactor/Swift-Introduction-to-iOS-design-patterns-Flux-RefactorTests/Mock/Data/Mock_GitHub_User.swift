//
//  Mock_GitHub_User.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-RefactorTests
//
//  Created by kazunori.aoki on 2021/10/14.
//

import GitHub

extension GitHub.User {
    static func mock() -> GitHub.User {
        return GitHub.User(login: "marty-suzuki",
                           id: 1,
                           nodeID: "nodeID",
                           avatarURL: URL(string: "https://avatars1.githubusercontent.com")!,
                           gravatarID: "",
                           url: URL(string: "https://github.com/marty-suzuki")!,
                           receivedEventsURL: URL(string: "https://github.com/marty-suzuki")!,
                           type: "User")
    }
}
