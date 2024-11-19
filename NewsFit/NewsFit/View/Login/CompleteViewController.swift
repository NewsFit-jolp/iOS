import UIKit

final class CompleteViewController: UIViewController {
  private let checkMarkImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .successMark)
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "맞춤 설정 완료!"
    label.font = .NF.title_large
    label.textColor = .label
    label.numberOfLines = 0
    
    return label
  }()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "뉴스핏을 시작할 준비가 되었어요.\n지금 바로 맞춤 뉴스를 읽어보세요."
    label.font = .NF.title_middle
    label.textColor = .label
    label.numberOfLines = 0
    
    return label
  }()
  private let confirmButton: UIButton = ButtonFactory().make(
    title: "시작하기",
    textColor: .white,
    image: nil,
    backgroundColor: .nfButtonBackgroundBlack
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configureHirachy()
    addAction()
  }
  
  private func configureHirachy() {
    let stackView = UIStackView(arrangedSubviews: [checkMarkImageView, titleLabel, descriptionLabel])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.alignment = .center
    stackView.distribution = .fillProportionally
    
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-30)
    }
    
    view.addSubview(confirmButton)
    confirmButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
      make.centerX.equalToSuperview()
    }
  }
  private func addAction() {
    let action = UIAction { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    confirmButton.addAction(action, for: .touchUpInside)
  }
}
