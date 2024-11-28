struct NetworkResponseDTO<T: Decodable>: Decodable {
  let statusCode: Int
  let message: String
  let result: T
}
struct NetworkPagingResponseDTO<T: Decodable>: Decodable {
  let statusCode: Int
  let hasMore: Bool
  let message: String
  let result: T
}
