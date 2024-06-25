//
//  ViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 20.06.2024.
//

import UIKit

final class RMTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        view.backgroundColor = .systemBackground
    }

    private func setupTabs() {
        /// Init vcs
        let characterVC = RMCharacterViewController()
        let settingsVC = RMSettingsViewController()
        let episodeVC = RMEpisodeViewController()
        let locationVC = RMLocationViewController()
        
        /// Tittle mode automatic
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        
        /// Init UINavigationController 
        let characterNav = UINavigationController(rootViewController: characterVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        let episodeNav = UINavigationController(rootViewController: episodeVC)
        let locationNav = UINavigationController(rootViewController: locationVC)
    
        /// Init UITabBarItem
        characterNav.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 0)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        episodeNav.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(systemName: "tv"), tag: 2)
        locationNav.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), tag: 3)
        
        for nav in [characterNav, settingsNav, episodeNav, locationNav]{
            nav.navigationBar.prefersLargeTitles = true
        }
        tabBar.tintColor = .label
        setViewControllers([characterNav, settingsNav, episodeNav, locationNav], animated: true)
    }
}
