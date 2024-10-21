import SwiftUI

struct NewsCell: View {
  //MARK: - Property
  @State var viewModel: NewsPresentable & PressImagePresentable
  
  //MARK: - View
  var body: some View {
    HStack {
      imageView()
      VStack(alignment: .leading) {
        Text(viewModel.title)
          .font(.headline)
          .lineLimit(2)
        descriptionView(viewModel)
      }
    }
  }
  
  //MARK: - Helpers
  @ViewBuilder
  private func imageView() -> some View {
    Image(.successMark)
      .resizable()
      .scaledToFit()
      .frame(maxWidth: 70, maxHeight: 70)
      .background(Color.black)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .padding(.trailing, 20)
  }
  @ViewBuilder
  private func descriptionView(_ viewModel: NewsPresentable & PressImagePresentable) -> some View {
    HStack(spacing: 10) {
      Image(.kakaoLogo)
        .resizable()
        .scaledToFit()
        .frame(minWidth: 20, maxWidth: 20)
      Text(viewModel.press)
        .bold()
      Text("·")
      Text(viewModel.date)
    }
  }
}

//MARK: - Preview
#Preview {
  NewsCell(
    viewModel: NewsViewModel(
      title: "고양이가 그렇게 귀엽다며... 사료를 1년치 주문... 충격",
      press: "카카오또-끄",
      createdDate: .init(timeIntervalSinceNow: -60*60)
    )
  )
}
