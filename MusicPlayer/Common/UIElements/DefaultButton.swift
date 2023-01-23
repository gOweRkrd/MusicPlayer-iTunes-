import UIKit

final class DefaultButton: UIButton {

    init(titleText: String) {
        super.init(frame: .zero)
        setTitle(titleText, for: .normal)
        titleLabel?.font = .interRegular(size: 14)
        layer.cornerRadius = CGFloat.baseCornerRadius
        backgroundColor = .systemMint
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
