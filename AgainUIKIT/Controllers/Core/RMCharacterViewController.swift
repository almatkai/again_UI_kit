//
//  RMCharacterViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        
        let status: RMCharacterStatus = .alive
        let request = RMRequest(endpoint: .character, queryParameters: [.init(name: "page", value: "2"), .init(name: "name", value: "rick"), .init(name: "status", value: status.rawValue)])
        
        RMService.shared.execute(request, expecting: RMCharacter.self, completion: { res in
            switch res {
            case .success(let success):
                print(success.self)
            case .failure(let failure):
                print()
            }
        })
    }

}
