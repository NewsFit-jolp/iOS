import Foundation

final class TopicSubscriptionViewModel: ObservableObject {
  @Published
  var topics: [TopicSubscriptionCellViewModel] = [
    .init(icon: "🏛️", name: "정치"),
    .init(icon: "💰", name: "경제"),
    .init(icon: "👥", name: "사회"),
    .init(icon: "🏠", name: "생활/문화"),
    .init(icon: "🌏", name: "세계"),
    .init(icon: "💻", name: "기술/IT"),
    .init(icon: "🎤", name: "연예"),
    .init(icon: "⚽", name: "스포츠"),
  ]
  
  func saveTopics() {
    // Save selected topics
  }
  func isValid() -> Bool {
    isSelectedMoreThanThree()
  }
  private func isSelectedMoreThanThree() -> Bool {
    topics.filter { $0.isPressed }.count >= 3
  }
}


struct TopicSubscriptionCellViewModel {
  var isPressed: Bool = false
  let icon: String
  let name: String
}
