struct NetworkResponseDTO<T: Decodable>: Decodable {
  let statusCode: Int
  let message: String
  let result: T
}
