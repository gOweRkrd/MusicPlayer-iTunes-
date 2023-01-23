import UIKit

final class TitleLabel: UILabel {

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
        textAlignment = .center
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
