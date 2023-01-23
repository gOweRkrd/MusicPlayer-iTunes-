import UIKit

extension UIFont {

    // MARK: - Bold
    static func interBold(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Inter-Bold", size: size)
    }
    static func poppinsBold(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Poppins-Bold", size: size)
    }

    // MARK: - Regular

    static func interRegular(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Inter-Regular", size: size)
    }
    static func poppinsRegular(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Poppins-Regular", size: size)
    }
}
