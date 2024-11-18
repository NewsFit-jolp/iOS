import SwiftUI
import SafariServices

struct NewsDetailSheet: View {
  @Environment(\.dismiss) private var dismiss
  @State private var isPresentWebView = false
  @ObservedObject var viewModel: NewsDetailViewModel
  @State private var didTapDelete = false
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
        .padding(.top)
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
      .animation(.bouncy, value: viewModel.selectedAt)
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .bottomSheet(isShowing: $didTapDelete, topOffset: 200) {
      Text("삭제하시겠습니까?")
    }
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
        VStack {
          ForEach(viewModel.newsDetail?.comment ?? [], id: \.self) { comment in
            commentView(comment)
          }
        }
        .padding(30)
      }
    }
  }
  @ViewBuilder // 댓글 입력 뷰
  private func commentInput() -> some View {
    HStack {
      TextField(text: $viewModel.commentText) {
        Text("댓글을 입력하세요")
      }
      .padding(.horizontal)
      .font(.NF.text_default)
      .background(Color.nfBackgroundAccent)
      Button(action: {
        viewModel.didTapSendComment()
      }) {
        Image(.nfCommentButton)
          .frame(width: 70, height: 45)
          .foregroundStyle(Color.white)
          .background(Color.nfPurple)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .frame(height: 45)
    .background(Color.nfBackgroundAccent)
    .clipShape(
      RoundedRectangle(cornerRadius: 10)
    )
    .padding(.horizontal)
    .padding(.bottom)
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
        Button(action: {
          viewModel.didTapEraseComment(at: comment.id)
//          didTapDelete.toggle()
        }) {
          Image(.nfxButton)
        }
      }
      // 왼쪽 정렬
      Text(comment.content)
        .font(.NF.text_default)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(5)
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
      miniButton(image: .robot, string: "AI 요약", idx: 0)
        .foregroundStyle(
          viewModel.selectedAt == 0
          ? Color.nfGreen
          : Color.gray
        )
      Spacer()
      miniButton(image: .nfComment, string: "댓글", idx: 1)
        .foregroundStyle(
          viewModel.selectedAt == 1
          ? Color.nfGreen
          : Color.gray
        )
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


struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    let topOffset: CGFloat // 상단 offset
    let sheetContent: () -> SheetContent // bottomSheet의 내용
    
    @State private var dragOffset: CGFloat = 0 // 핸들 제스쳐에 필요한 값
    
    @State var bottomSheetSize: CGSize = .zero
    /// bottomSheetOffset: isShowing이 false일 때는, bottomSheetSize만큼 화면 아래에 그려짐.
    private var bottomSheetOffset: CGFloat {
        isShowing ? 0 : bottomSheetSize.height
    }
    
    func body(content: Content) -> some View {
        ZStack { // content와 dim배경과 bottomSheet가 ZStack으로 그려짐
            content
            
            if isShowing {
                // BottomSheet의 dim배경
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture { // Tap하면 애니메이션과 함께 닫힘
                        withAnimation {
                            isShowing = false
                        }
                    }
                    .transition(.opacity)
            }
            
            // BottomSheet
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Rectangle() // BottomSheet의 핸들
                        .frame(width: 50, height: 4)
                        .cornerRadius(2)
                        .padding(.vertical, 8)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if dragOffset + value.translation.height > 0 {
                                        dragOffset += value.translation.height
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.height > 0 {
                                        isShowing = false
                                    } else {
                                        isShowing = true
                                    }
                                    dragOffset = 0
                                }
                        )
                    
                    sheetContent() // BottomSheet의 content
                        .frame(maxHeight: UIScreen.main.bounds.height - topOffset) // 최대높이를 제한
                        .frame(width: UIScreen.main.bounds.width) // 너비는 스크린 너비만큼
                        .fixedSize(horizontal: false, vertical: true) // 자식뷰들에게 높이(vertical)는 고정사이즈로 그리기를 제안함. 이 제안으로 sheetContent의 높이가 작을 때 사이즈에 맞게 bottomSheet가 그려짐.
                        .padding(.top)
                }
                .frame(width: bottomSheetSize.width, height: bottomSheetSize.height)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: bottomSheetOffset + dragOffset)
                .animation(.easeInOut(duration: 0.25), value: isShowing)
                .shadow(radius: 10)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

extension View {
    func bottomSheet<SheetContent: View>(isShowing: Binding<Bool>, topOffset: CGFloat = .zero, @ViewBuilder sheetContent: @escaping () -> SheetContent) -> some View {
        self.modifier(BottomSheetModifier(isShowing: isShowing, topOffset: topOffset, sheetContent: sheetContent))
    }
}
