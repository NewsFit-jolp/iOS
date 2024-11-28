//
//  CacheImageData.swift
//  Data
//
//  Created by 임정현 on 10/16/24.
//

import Foundation

final class CacheImageData: Sendable, Codable {
  let imageData: Data
  let etag: String
  
  init(imageData: Data, etag: String) {
    self.imageData = imageData
    self.etag = etag
  }
}

final class CacheStatusWrapper {
	enum CacheStatus {
    case downloading(_ task: Task<CacheImageData, Error>)
    case downloaded(_ data: CacheImageData)
  }
  
  let status: CacheStatus
  
  init(_ status: CacheStatus) {
    self.status = status
  }
}
