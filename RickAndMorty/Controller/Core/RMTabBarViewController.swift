//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // run at controller startup
        setupTabs()
    }

    /*
        Deleted main.storyboard
        Removed references to the main.storyboard file from Custom iOS Target Properties
        in the application settings's info tab
            - deleted 'Main storyboard file base name' property
            - deleted 'Storyboard Name' property under the following path
                    'Application Scene Manifest'
                        'Scene Configuration'
                            'Application Session Role'
                                'Item 0 (Default Configuration)'
                                    -->'Storyboard Name'<--
     
     */
    private func setupTabs() {
        // create instances of our view controllers
        let characterVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        /* automatic causes the title to use the same styling as the
         previously displayed navigation item. If the prefersLargeTitles
         property of the navigation bar is false, this property has no
         effect and the navigation item’s title is always displayed as a small title. */
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // create instances of UINavigationController with a provided root UIViewController
        let nav1 = UINavigationController(rootViewController: characterVC);
        let nav2 = UINavigationController(rootViewController: locationsVC);
        let nav3 = UINavigationController(rootViewController: episodeVC);
        let nav4 = UINavigationController(rootViewController: settingsVC);
        
        nav1.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person"),
            tag: 1)
        nav2.tabBarItem = UITabBarItem(
            title: "Locations",
            image: UIImage(systemName: "globe"),
            tag: 2)
        nav3.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "tv"),
            tag: 3)
        nav4.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            // sets the UINavigationController's navigationBar title to large
            nav.navigationBar.prefersLargeTitles = true
            
            /* When the property is set to false, the navigation bar displays the title inline with the other bar button items. */
        }
        
        // sets the root view controller for each tab
        setViewControllers([
            nav1,
            nav2,
            nav3,
            nav4,
        ], animated: true)
    }
}

