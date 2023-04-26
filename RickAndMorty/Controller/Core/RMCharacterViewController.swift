//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import UIKit

/// Controller to show and search for Characters
// UIViewController - An object that manages a view hierarchy for your UIKit app.
// THIS CONTROLLER CONTAINS THE RMCHARACTERLISTVIEW
final class RMCharacterViewController: UIViewController {
    
    // UIView that contains the UICollectionView and the UIActivityIndicatorView
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
        setUpView()

    }
    
    // characterListView encapsulates the loading spinner and a UICollectionView
    private func setUpView() {
        // sets the UIView that the controller manages
        view.backgroundColor = .systemBackground
        
        // addSubView - Adds a view to the end of the receiver’s list of subviews.
        view.addSubview(characterListView)
        
        // the characterListView achors must match the ViewControllers layout guide anchors.
        // https://www.hackingwithswift.com/articles/140/the-auto-layout-cheat-sheet
        NSLayoutConstraint.activate([
            // The layout guide representing the portion of your view that is unobscured by bars and other content.
            // safeAreaLayoutGuide - The layout guide representing the portion of your view that is unobscured by bars and other content.
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
