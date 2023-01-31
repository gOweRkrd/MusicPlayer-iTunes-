import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupTabBar()
    }

    // MARK: - Private Methods

    private func generateTabBar() {
        viewControllers = [

            generateVC(
                viewController: UINavigationController(rootViewController: MainScreenViewController()),
                image: UIImage(systemName: "house.fill")
            ),

            generateVC(
                viewController: SoundLayerController(),
                image: UIImage(systemName: "play.circle")
            ),
            
//            generateVC(
//                viewController: SearchController(),
//                image: UIImage(systemName: "magnifyingglass.circle")
//            ),

            generateVC(
                viewController: FavouritesViewController(),
                image: UIImage(systemName: "heart")
            ),

            generateVC(
                viewController: UserInfoController(),
                image: UIImage(systemName: "person")
            )
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }

    private func setupTabBar() {
        tabBar.backgroundColor = UIColor(named: "tabBarColor")
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
