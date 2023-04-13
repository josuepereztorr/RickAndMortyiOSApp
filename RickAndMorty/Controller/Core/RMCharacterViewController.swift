//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(
            endpoint: RMEndpoint.character,
            pathComponents: ["1"],
            queryParamters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive")
            ]
        )
        
        print(request.url)
        
        
    }

}
