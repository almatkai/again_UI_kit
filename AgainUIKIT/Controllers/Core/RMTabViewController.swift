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
        view.tintColor = UIColor(.accentColor)
    }

    private func setupTabs() {
        /// Init vcs
        let characterVC = RMCharacterViewController()
        let episodeVC = RMEpisodeViewController()
        let locationVC = RMLocationViewController()
        let settingsVC = RMSettingsViewController()
        
        /// Init UINavigationController
        let characterNav = UINavigationController(rootViewController: characterVC)
        let episodeNav = UINavigationController(rootViewController: episodeVC)
        let locationNav = UINavigationController(rootViewController: locationVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
    
        /// Init UITabBarItem
        characterNav.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 0)
        episodeNav.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(systemName: "tv"), tag: 1)
        locationNav.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), tag: 2)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        for nav in [characterNav, episodeNav, locationNav, settingsNav]{
            nav.navigationBar.prefersLargeTitles = true
        }
        self.selectedIndex = 2
        tabBar.tintColor = .label
        setViewControllers([characterNav, episodeNav, locationNav, settingsNav], animated: true)
    }
}
