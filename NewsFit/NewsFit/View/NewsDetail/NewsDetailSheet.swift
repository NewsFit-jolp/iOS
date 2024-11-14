import SwiftUI
import SafariServices

struct NewsDetailSheet: View {
  @Environment(\.dismiss) private var dismiss
  @State private var isPresentWebView = false
  @ObservedObject var viewModel: NewsDetailViewModel
  var body: some View {
    VStack {
      ZStack {
        Spacer()
      }
      .background(Color.black.opacity(0.0000001))
      .onTapGesture {
        viewModel.isPresented = false
        dismiss()
      }
      VStack {
        VStack {
          textBox(text: viewModel.newsDetail?.title ?? "", font: .NF.title_headline, borderColor: .nfBorderDefault)
          buttonStack()
            .padding(.vertical, 10)
          aiSummary()
        }
        .padding(.vertical)
        .background (
          Gradient(colors: [.nfBackgroundAccent, .white])
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        commentList()
        Button(action: {
          isPresentWebView = true
        })
        {
          Text("기사 링크로 이동")
            .font(.NF.button_default)
            .foregroundStyle(Color.white)
            .frame(width: 331, height: 52)
            .background(Color.nfButtonBackgroundBlack)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top, 10)
        .fullScreenCover(isPresented: $isPresentWebView) {
          SafariWebView(url: URL(string: viewModel.newsDetail?.articleSource ?? "")!)
            .ignoresSafeArea()
        }
        Button(action: {
          viewModel.isPresented = false
          dismiss()
        })
        {
          Text("닫기")
            .font(.NF.button_default)
            .foregroundStyle(Color.black)
            .frame(width: 331, height: 52)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .ignoresSafeArea(.all, edges: .bottom)
  }
  
  @ViewBuilder
  private func miniButton(image: ImageResource, string: String, idx: Int) -> some View {
    Button(action: {
      if idx == 2 { viewModel.didTapLike() }
      else { viewModel.selectedAt = idx }
    }, label: {
      Image(image)
        .renderingMode(.template)
      Text(string)
        .font(.NF.button_small)
    })
    .frame(height: 31)
    .padding(.horizontal, 10)
    .background()
    .clipShape(RoundedRectangle(cornerRadius: 20))
    
  }
  @ViewBuilder
  private func aiSummary() -> some View {
    if viewModel.selectedAt == 0 {
      textBox(text: viewModel.newsDetail?.content ?? "", font: .NF.text_default, borderColor: .nfGreen)
    }
  }
  @ViewBuilder
  private func commentList() -> some View {
    if viewModel.selectedAt == 1 {
      VStack {
        commentInput()
        Divider()
        ForEach(viewModel.newsDetail?.comment ?? [], id: \.self) { comment in
          commentView(comment)
        }
      }
    }
  }
  @ViewBuilder // 댓글 입력 뷰
  private func commentInput() -> some View {
    HStack {
      TextField(text: $viewModel.commentText) {
        Text("댓글을 입력하세요")
      }
      Rectangle()
    }
  }
  @ViewBuilder
  private func commentView(_ comment: Comment) -> some View {
    VStack {
      HStack {
        Text(comment.author)
          .font(.NF.text_bold)
        Text(comment.createdAt.koTime)
          .font(.NF.text_sub)
          .foregroundStyle(Color.secondary)
        Spacer()
        Image(.nfxButton)
      }
      // 왼쪽 정렬
      Text(comment.content)
        .font(.NF.text_default)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  @ViewBuilder
  private func textBox(text: String, font: Font, borderColor: Color) -> some View {
    Text(text)
      .font(font)
      .frame(width: 300)
      .padding()
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .overlay {
        RoundedRectangle(cornerRadius: 10)
          .stroke(borderColor, lineWidth: 2)
      }
  }
  @ViewBuilder
  private func buttonStack() -> some View {
    HStack {
      Spacer()
      if viewModel.selectedAt == 0 {
        miniButton(image: .robot, string: "AI 요약", idx: 0)
          .foregroundStyle(Color.nfGreen)
      } else {
        miniButton(image: .robot, string: "AI 요약", idx: 0)
          .foregroundStyle(Color.gray)
      }
      Spacer()
      if viewModel.selectedAt == 1 {
        miniButton(image: .nfComment, string: "댓글", idx: 1)
          .foregroundStyle(Color.nfGreen)
      } else {
        miniButton(image: .nfComment, string: "댓글", idx: 1)
          .foregroundStyle(Color.gray)
      }
      Spacer()
      miniButton(image: .nfLike, string: "20", idx: 2)
        .foregroundStyle(
          viewModel.newsDetail?.likedArticle == true ? Color.nfGreen : Color.gray
        )
      Spacer()
    }
  }
}


#Preview {
  let viewModel: NewsDetailViewModel =  {
    let vm = NewsDetailViewModel()
    vm.selectedAt = 1
    return vm
  }()
  NewsDetailSheet(viewModel: viewModel)
}

// MARK: - safariwebveiw

struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
