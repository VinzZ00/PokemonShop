//
//  AppDelegate.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    // MARK: IOS 12+
    
    var window: UIWindow?
    var blurEffectView: UIVisualEffectView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = setupNavigationTabBar()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.addBlurEffect()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.removeBlurEffect()
    }
    
    // MARK: UISceneSession Lifecycle IOS13
    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//    
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
}

extension AppDelegate {
    
    func setupNavigationTabBar() -> UITabBarController {
        let uiTabBar = UITabBarController()
        
        let pokemonShop = UINavigationController(rootViewController: PokemonShopViewController())
        let qrCodeScanenrView = UINavigationController(rootViewController: QRCodeScannerViewController())
        let pokemonsHome = UINavigationController(rootViewController: PokemonsHomeViewController())
        
        
        pokemonShop.tabBarItem = UITabBarItem(title: "Pokemon Shop", image: UIImage(named: "house"),selectedImage: UIImage(named: "house.fill"))
        qrCodeScanenrView.tabBarItem = UITabBarItem(title: "Scan QR", image: UIImage(named: "qrcode.viewfinder"), selectedImage: UIImage(named: "qrcode.viewfinder"))
        pokemonsHome.tabBarItem = UITabBarItem(title: "Pokemons", image: UIImage(named: "paw"),selectedImage: UIImage(named: "paw.fill"))
        
        
        uiTabBar.viewControllers = [pokemonShop, qrCodeScanenrView, pokemonsHome]
//        uiTabBar.viewControllers?.forEach{
//            $0.view.backgroundColor = .white
//        }
        return uiTabBar
    }
}

extension AppDelegate {
    private func addBlurEffect() {
        guard let window = window else { return }
        
        let blurEffect = UIBlurEffect(style: .light) // Choose the desired blur effect style
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = window.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        window.addSubview(blurEffectView!)
    }
    
    private func removeBlurEffect() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
}
