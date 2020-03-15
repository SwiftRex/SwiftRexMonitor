import UIKit
@testable import Counter

import Combine
extension Publisher where Failure == Never {
    public static func sync(work: @escaping () -> Output) -> AnyPublisher<Output, Never> {
        return Deferred {
            Just(work())
        }.eraseToAnyPublisher()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if ProcessInfo.processInfo.environment["UI_TESTS"] == "1" {
            UIView.setAnimationsEnabled(false)
            Counter.Current.nthPrime = { _ in .sync { 3 } }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
