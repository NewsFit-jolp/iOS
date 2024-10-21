import SwiftUI

struct NewsCategoryCell: View {
  var body: some View {
    Text("전체")
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(Color.nfPurple)
      .foregroundStyle(.white)
      .clipShape (
        RoundedRectangle(cornerRadius: 16)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.nfBorderDefault)
      }
  }
}

#Preview {
  NewsCategoryCell()
}
