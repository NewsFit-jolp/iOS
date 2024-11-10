import SwiftUI

struct NewsDetailSheet: View {
  var body: some View {
    VStack {
      Text("앙 최악의 기후재앙 어쩌구 브라질 어쩌구저쩌구 쏴로라ㅗ라롸롸롸롸로라ㅗ라ㅘ라로")
        .font(.NF.title_headline)
        .frame(width: 300)
        .padding(.vertical, 10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.nfBorderDefault, lineWidth: 2)
        }
      HStack {
        Spacer()
        miniButton(image: .robot, string: "AI 요약")
          .foregroundColor(.gray)
        Spacer()
        miniButton(image: .nfComment, string: "댓글")
        Spacer()
        miniButton(image: .nfLike, string: "20")
        Spacer()
      }
      .padding(.vertical, 10)
      Button(action: {print("GG")}) {
        Text("기사 링크로 이동")
          .font(.NF.button_default)
          .foregroundStyle(Color.white)
          .frame(width: 331, height: 52)
          .background(Color.nfButtonBackgroundBlack)
      }
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.top, 10)
      Button(action: {print("GG")}) {
        Text("닫기")
          .font(.NF.button_default)
          .foregroundStyle(Color.black)
          .frame(width: 331, height: 52)
          .background(Color.white)
      }
      .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.vertical)
    .background (
      Gradient(colors: [.nfBackgroundAccent, .white])
    )
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
  
  @ViewBuilder
  private func miniButton(image: ImageResource, string: String) -> some View {
    HStack {
      Image(image)
        .renderingMode(.template)
      Text(string)
        .font(.NF.button_small)
    }
    .frame(height: 31)
    .padding(.horizontal, 10)
    .background()
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}


#Preview {
  NewsDetailSheet()
}
