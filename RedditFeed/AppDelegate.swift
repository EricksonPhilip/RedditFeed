//
//  AppDelegate.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        configureNavigationBar(largeTitleColor: UIColor(named: "titleColor") ?? .white,
                               backgoundColor: UIColor(named: "NavBkgColor") ?? .white,
                               tintColor: UIColor(named: "titleColor")!,
                               title: "Reddit Feed",
                               preferredLargeTitle: true)
        
        return true
    }
    
    func configureNavigationBar(largeTitleColor: UIColor,
                                backgoundColor: UIColor,
                                tintColor: UIColor,
                                title: String,
                                preferredLargeTitle: Bool) {
        let navigationController = UINavigationController(rootViewController: RedditFeedController())
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.compactAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = tintColor
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
    }
}

