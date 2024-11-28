import SwiftUI
import CachedAsyncImage

struct HeadLineNewsCell: View {
  //MARK: - Type
  typealias ViewModel = NewsPresentable & NewsDescriptionPresentable
  
  //MARK: - Properties
  @State var viewModel: ViewModel
  @State var image: Image?
  
  //MARK: - View
  var body: some View {
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
    .background {
      CachedAsyncImage(url: viewModel.imageURL) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
        case .failure:
          Image(.nfxButton)
            .resizable()
        default:
          ProgressView()
        }
      }
      .scaledToFill()
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
    
  }
  
  //MARK: - Helper
  @ViewBuilder
  private func centerTitleAndBody(_ viewModel: ViewModel) -> some View {
    VStack(alignment: .leading) {
      Text(viewModel.title)
        .font(.NF.title_headline)
        .foregroundStyle(.white)
        .padding(.bottom)
      Text(viewModel.body)
        .font(.NF.text_headline)
        .foregroundStyle(.white)
    }
  }
  @ViewBuilder
  private func bottomDescription(_ viewModel: ViewModel) -> some View {
    HStack {
      Text(viewModel.press)
        .foregroundStyle(.white)
      Spacer()
      Text(viewModel.date)
        .foregroundStyle(.white)
    }
    .font(.NF.text_headline)
  }
}

//MARK: - Preview
#Preview {
  HeadLineNewsCell(
    viewModel: HeadLineNewsViewModel(
      id: 1,
      title: "dma",
      press: "한겨레",
      body: "부상자 361명, 15만5천명 대피",
      imageURL: nil,
      createdDate: .now
    )
  )
}
