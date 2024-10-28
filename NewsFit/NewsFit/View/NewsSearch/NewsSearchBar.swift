//
//  SearchBar.swift
//  NewsFit
//
//  Created by user on 10/23/24.
//

import SwiftUI

struct NewsSearchBar: View {
  @Binding var text: String
  var body: some View {
    HStack {
      TextField("키워드 / 언론사 / 카테고리로 검색", text: $text)
      Image(.nfSearchButton)
    }
    .padding(.horizontal)
    .padding(.vertical, 10)
    .modifier(NFBorderModifier())
    .padding(.horizontal)
  }
}


