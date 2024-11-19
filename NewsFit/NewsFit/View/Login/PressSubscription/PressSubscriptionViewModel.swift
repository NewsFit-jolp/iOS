import Foundation

final class PressSubscriptionViewModel: ObservableObject {
  @Published var pressList: [PressSubscription] = [
    .init(title: "경향신문"),
    .init(title: "국민일보"),
    .init(title: "동아일보"),
    .init(title: "문화일보"),
    .init(title: "서울신문"),
    .init(title: "세계일보"),
    .init(title: "조선일보"),
    .init(title: "중앙일보"),
    .init(title: "한겨레"),
    .init(title: "한국일보"),
    .init(title: "뉴스1"),
    .init(title: "뉴시스"),
    .init(title: "연합뉴스"),
    .init(title: "연합뉴스TV"),
    .init(title: "채널A"),
    .init(title: "한국경제TV"),
    .init(title: "JTBC"),
    .init(title: "KBS"),
    .init(title: "MBC"),
    .init(title: "MBN"),
    .init(title: "SBS"),
    .init(title: "SBS Biz"),
    .init(title: "TV조선"),
    .init(title: "YTN"),
    .init(title: "매일경제"),
    .init(title: "머니투데이"),
    .init(title: "비즈워치"),
    .init(title: "서울경제"),
    .init(title: "아시아경제"),
    .init(title: "이데일리"),
    .init(title: "조선비즈"),
    .init(title: "조세일보"),
    .init(title: "파이낸셜뉴스"),
    .init(title: "한국경제"),
    .init(title: "헤럴드경제"),
    .init(title: "노컷뉴스"),
    .init(title: "더팩트"),
    .init(title: "데일리안"),
    .init(title: "머니S"),
    .init(title: "미디어오늘"),
    .init(title: "아이뉴스24"),
    .init(title: "오마이뉴스"),
    .init(title: "프레시안"),
    .init(title: "디지털데일리"),
    .init(title: "디지털타임스"),
    .init(title: "블로터"),
    .init(title: "전자신문"),
    .init(title: "지디넷코리아"),
    .init(title: "더스쿠프"),
    .init(title: "레이디경향"),
    .init(title: "매경이코노미"),
    .init(title: "시사IN"),
    .init(title: "시사저널"),
    .init(title: "신동아"),
    .init(title: "월간 산"),
    .init(title: "이코노미스트"),
    .init(title: "주간경향"),
    .init(title: "주간동아"),
    .init(title: "주간조선"),
    .init(title: "중앙SUNDAY"),
    .init(title: "한겨레21"),
    .init(title: "한경비즈니스"),
    .init(title: "기자협회보"),
    .init(title: "농민신문"),
    .init(title: "뉴스타파"),
    .init(title: "동아사이언스"),
    .init(title: "여성신문"),
    .init(title: "일다"),
    .init(title: "코리아중앙데일리"),
    .init(title: "코리아헤럴드"),
    .init(title: "코메디닷컴"),
    .init(title: "헬스조선"),
    .init(title: "강원도민일보"),
    .init(title: "광주일보"),
    .init(title: "경기일보"),
    .init(title: "국제신문"),
    .init(title: "대구MBC"),
    .init(title: "대전일보"),
    .init(title: "매일신문"),
    .init(title: "부산일보"),
    .init(title: "전주MBC"),
    .init(title: "CJB청주방송"),
    .init(title: "JIBS"),
    .init(title: "KBC광주방송"),
    .init(title: "신화사"),
    .init(title: "연합뉴스 포토"),
    .init(title: "AP"),
    .init(title: "EPA")
  ]
  
  func fetchPressList() {
    
  }
  func savePressList() {
    
  }
  func isValid() -> Bool {
    isPressSelected()
  }
  private func isPressSelected() -> Bool {
    pressList.filter{ $0.isSelected }.count >= 3
  }
}

struct PressSubscription {
  let title: String
  var isSelected: Bool = false
}
