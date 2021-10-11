//
//  SceneDelegate.swift
//  Checklist_NoSB
//
//  Created by Seok Jun Noh on 9/20/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

//MARK: Step 1: Initialize window
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options
              connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    // Initialize the variable 'window' with the size of the typecasted scene (now UIWindowScene)
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    
    // Assign main window's windowScene to the calling scene
    window?.windowScene = windowScene
    
    // Create a navigation controller and set the ChecklistController as a root
    let navController = UINavigationController(rootViewController: ChecklistController())
    navController.navigationBar.prefersLargeTitles = true
    
    // Next line makes the navController(with ChecklistController as its rootView) window's rootController
    window?.rootViewController = navController
    
    // Display the window
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
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }


}

