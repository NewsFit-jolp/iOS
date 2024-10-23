import SwiftUI

struct NFBorderModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .clipShape (
        RoundedRectangle(cornerRadius: 16)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.nfBorderDefault)
      }
  }
}
