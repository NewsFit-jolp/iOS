import Foundation

struct ImageService {
  func fetchImageData(from url: URL) async -> Data? {
    let request = URLRequest(url: url)
    return try? await HTTPServiceProvider().fetchData(for: request).get()
  }
}
