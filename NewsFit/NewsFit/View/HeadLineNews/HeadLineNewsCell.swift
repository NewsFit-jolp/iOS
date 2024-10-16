import SwiftUI

struct HeadLineNewsCell: View {
  var body: some View {
    VStack {
      Spacer()
      VStack(alignment: .leading) {
        Text("\"최악의 기후재앙\"...브라질 남부 폭우에 사망.실종 220명 넘어서")
          .font(.headline)
          .padding(.bottom)
        Text("부상자 361명, 15만5천명 대피")
      }
      Spacer()
      HStack {
        Text("한겨레")
        Spacer()
        Text("2024.05.28")
      }
    }.padding()
  }
}

#Preview {
  HeadLineNewsCell()
}
