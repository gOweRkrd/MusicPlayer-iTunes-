import UIKit

final class LabelSetup: UILabel {

    init(title: String) {
        super.init(frame: .zero)
        text = title
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        font = UIFont.init(name: "Inter-Bold", size: 30)
        textAlignment = .left
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
