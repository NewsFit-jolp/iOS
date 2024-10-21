import SwiftUI

struct HeadLineNewsCell: View {
  //MARK: - Properties
  @State var viewModel: HeadLineNewsPresentable
  
  //MARK: - View
  var body: some View {
    ZStack {
      Image(.newsFitLogo)
        .resizable()
        .scaledToFit()
      VStack(alignment: .leading) {
        Spacer()
        centerTitleAndBody(viewModel)
        Spacer()
        bottomDescription(viewModel)
      }
      .padding()
      .background(
        Gradient(
          colors: [
            .black.opacity(0.1),
            .black.opacity(0.6)
          ]
        )
      )
      .clipShape(RoundedRectangle(cornerRadius: 16))
    }
  }
  
  //MARK: - Helper
  @ViewBuilder
  private func centerTitleAndBody(_ viewModel: HeadLineNewsPresentable) -> some View {
    VStack(alignment: .leading) {
      Text(viewModel.title)
        .font(.headline)
        .foregroundStyle(.white)
        .padding(.bottom)
      Text(viewModel.body)
        .foregroundStyle(.white)
    }
  }
  @ViewBuilder
  private func bottomDescription(_ viewModel: HeadLineNewsPresentable) -> some View {
    HStack {
      Text(viewModel.press)
        .foregroundStyle(.white)
      Spacer()
      Text(viewModel.date)
        .foregroundStyle(.white)
    }
  }
}

//MARK: - Preview
#Preview {
  HeadLineNewsCell(
    viewModel: HeadLineNewsViewModel(
      title: "dma",
      press: "한겨레",
      body: "부상자 361명, 15만5천명 대피",
      imageURL: nil,
      createdDate: .now
    )
  )
}
