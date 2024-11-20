import SwiftUI

struct RecentlySearchedView: View {
  var body: some View {
    VStack {
      HStack {
        Text("최근검색어")
          .font(.NF.text_default)
        Spacer()
        Button(action: {}) {
          Text("모두 지우기")
            .font(.NF.text_default)
            .foregroundColor(.secondary)
        }
      }.padding(.bottom, 10)
      ScrollView(.horizontal) {
        HStack {
          ForEach(0..<0) { index in
            RecentlySerchedCell()
          }
        }
      }
      .scrollIndicators(.never)
    }
    .padding()
  }
}


fileprivate struct RecentlySerchedCell: View {
  var body: some View {
    HStack(alignment: .center) {
      Text("검색기록")
        .font(.NF.button_small)
      Spacer()
      Button(action: {}) {
        Image(.nfxButton)
      }
    }
    .padding(8)
    .modifier(NFBorderModifier())
    .padding(1)
  }
}
