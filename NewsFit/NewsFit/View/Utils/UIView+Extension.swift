import UIKit

extension UIView {
  /// 상위뷰가 없으면 안됨
  func addSubTitleLabel(of text: String) {
    let label = UILabel()
    label.text = text
    label.font = .NF.text_default
    label.textColor = .nfBorderDefault
    label.backgroundColor = .white
    
    if let superView = self.superview {
      superView.addSubview(label)
      label.snp.makeConstraints { make in
        make.centerY.equalTo(self.snp.top)
        make.leading.equalToSuperview().offset(10)
      }
    }
  }
}
