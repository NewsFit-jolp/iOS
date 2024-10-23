import SwiftUI

struct NewsCategoryCell: View {
  @State var viewModel: NewsCategoryViewModel
  var body: some View {
    Text(viewModel.value)
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(viewModel.isSelected ? .nfPurple : .white)
      .foregroundStyle(viewModel.isSelected ? .white : .black)
      .modifier(NFBorderModifier())
  }
}

#Preview {
  NewsCategoryCell(viewModel: .init(value: "전체", isSelected: true))
}
