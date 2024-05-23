//
//  SceneDelegate.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import UIKit
import Foundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var blurEffectView: UIVisualEffectView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = setupNavigationTabBar()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        removeBlurEffect()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        addBlurEffect()
    }


}

extension SceneDelegate {
    
    func setupNavigationTabBar() -> UITabBarController {
        let uiTabBar = UITabBarController()
        
        let pokemonShop = UINavigationController(rootViewController: PokemonShopViewController())
        let qrCodeScanenrView = UINavigationController(rootViewController: QRCodeScannerViewController())
        let pokemonsHome = UINavigationController(rootViewController: PokemonsHomeViewController())
        
        
        pokemonShop.tabBarItem = UITabBarItem(title: "Pokemon Shop", image: UIImage(systemName: "house"),selectedImage: UIImage(systemName: "house.fill"))
        qrCodeScanenrView.tabBarItem = UITabBarItem(title: "Scan QR", image: UIImage(systemName: "qrcode.viewfinder"), selectedImage: UIImage(systemName: "qrcode.viewfinder"))
        pokemonsHome.tabBarItem = UITabBarItem(title: "Pokemons", image: UIImage(named: "paw"),selectedImage: UIImage(named: "paw.fill"))
        
        
        uiTabBar.viewControllers = [pokemonShop, qrCodeScanenrView, pokemonsHome]
        
//        uiTabBar.viewControllers?.forEach{
//            $0.view.backgroundColor = .white
//        }
        return uiTabBar
    }
}

extension SceneDelegate {
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

