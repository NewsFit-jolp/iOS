import SwiftUI

struct HeadLineNewsCell: View {
  var body: some View {
    VStack {
      Spacer()
      VStack(alignment: .leading) {
        Text("\"최악의 기후재앙\"...브라질 남부 폭우에 사망.실종 220명 넘어서")
          .font(.headline)
          .foregroundStyle(.white)
          .padding(.bottom)
        Text("부상자 361명, 15만5천명 대피")
          .foregroundStyle(.white)
      }
      Spacer()
      HStack {
        Text("한겨레")
          .foregroundStyle(.white)
        Spacer()
        Text("2024.05.28")
          .foregroundStyle(.white)
      }
    }.padding()
      .background(
        Image(.newsFitLogo)
          .resizable()
          .scaledToFit()
      )
      .background(
        Gradient(
          colors: [
            .black.opacity(0.1),
            .black.opacity(0.6)
          ]
        ).blendMode(.multiply)
      )
  }
}

#Preview {
  HeadLineNewsCell()
}
