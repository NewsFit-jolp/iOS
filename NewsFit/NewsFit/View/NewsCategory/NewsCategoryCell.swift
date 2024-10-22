import SwiftUI

struct NewsCategoryCell: View {
  @State var viewModel: NewsCategoryViewModel
  var body: some View {
    Text(viewModel.value)
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(viewModel.isSelected ? .nfPurple : .white)
      .foregroundStyle(viewModel.isSelected ? .white : .black)
      .clipShape (
        RoundedRectangle(cornerRadius: 16)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.nfBorderDefault)
      }
  }
}

#Preview {
  NewsCategoryCell(viewModel: .init(value: "전체", isSelected: true))
}
