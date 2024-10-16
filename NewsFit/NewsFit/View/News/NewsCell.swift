import SwiftUI

struct NewsCell: View {
  var body: some View {
    HStack {
      Image(.successMark)
        .resizable()
        .scaledToFit()
        .frame(maxWidth: 70, maxHeight: 70)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.trailing, 20)
      VStack(alignment: .leading) {
        Text("고양이가 그렇게 귀엽다며... 사료를 1년치 주문... 충격")
          .font(.headline)
        HStack(spacing: 10) {
          Image(.kakaoLogo)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 20, maxWidth: 20)
          Text("카카오또-끄")
            .bold()
          Text("·")
          Text("3시간전")
        }
      }
    }
    .padding(10)
  }
}

#Preview {
  NewsCell()
}
