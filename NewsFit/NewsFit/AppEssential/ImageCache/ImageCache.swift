//
//  ImageChache.swift
//  Data
//
//  Created by 임정현 on 10/16/24.
//

import Foundation

protocol Cacheable {
	func convertToKey(from url: URL) -> NSString
}

extension Cacheable {
	func convertToKey(from url: URL) -> NSString {
		let urlStr = url.absoluteString
		
		return urlStr.replacingOccurrences(of: "/", with: "") as NSString
	}
}

public final actor ImageCache: Cacheable {
	enum CacheError: Error {
		case invalidImage
	}
	
	public static let shared = ImageCache()
	private let memoryCache = NSCache<NSString, CacheStatusWrapper>()
	private let diskCache = DiskCache()
	
	private init() {
		memoryCache.totalCostLimit = 1024 * 1024 * 10
	}

	public func image(from url: URL) async -> Data? {
		let key = convertToKey(from: url)
		
		// MemoryCache
		if let data = memoryCache.object(forKey: key) {
 			switch data.status {
				case let .downloaded(data):
					return try? await fetchCachedImage(from: url, saveFor: key, cacheData: data).imageData
				case let .downloading(task):
					return try? await task.value.imageData
			}
		}
			
		// DiskCache
		if let data = await diskCache.cacheImageData(for: key as String) {
			return try? await fetchCachedImage(from: url, saveFor: key, cacheData: data).imageData
		}

		return try? await fetchImage(from: url, saveFor: key).imageData
	}
}

private extension ImageCache {
	func fetchCachedImage(from url: URL, saveFor key: NSString, cacheData: CacheImageData) async throws -> CacheImageData {
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(cacheData.etag, forHTTPHeaderField: "If-None-Match")
		
		let task = Task {
			try await fetchCachedImage(for: request, cacheData: cacheData)
		}
		
		// 캐시에 저장
		memoryCache.setObject(.init(.downloading(task)), forKey: key)
		
		// 다운로드 받고
		do {
			let image = try await task.value
			memoryCache.setObject(.init(.downloaded(image)), forKey: key)
			await diskCache.saveCacheImageData(image, for: key as String)
			return image
		} catch {
			memoryCache.removeObject(forKey: key)
			throw CacheError.invalidImage
		}
	}
	
	func fetchCachedImage(for request: URLRequest, cacheData: CacheImageData) async throws -> CacheImageData {
		let (data, response) = try await URLSession.shared.data(for: request)
		guard let response = response as? HTTPURLResponse else { throw CacheError.invalidImage }
		if response.statusCode == 304 {
			return cacheData
		} else {
			let etag = response.allHeaderFields["Etag"] as? String ?? ""
			
			return CacheImageData(imageData: data, etag: etag)
		}
	}
	
	func fetchImage(from url: URL, saveFor key: NSString) async throws -> CacheImageData {
		let task = Task {
			try await fetchImage(from: url)
		}
		
		// 캐시에 저장
		memoryCache.setObject(.init(.downloading(task)), forKey: key)
		
		// 다운로드 받고
		do {
			let image = try await task.value
			memoryCache.setObject(.init(.downloaded(image)), forKey: key)
			await diskCache.saveCacheImageData(image, for: key as String)
			return image
		} catch {
			memoryCache.removeObject(forKey: key)
			throw CacheError.invalidImage
		}
	}
	
	func fetchImage(from url: URL) async throws -> CacheImageData {
		var imageRequest = URLRequest(url: url)
		imageRequest.httpMethod = "GET"
		
		let (data, response) = try await URLSession.shared.data(for: imageRequest)
		guard let response = response as? HTTPURLResponse else { throw CacheError.invalidImage }
		
		let etag = response.allHeaderFields["Etag"] as? String ?? ""
		
		return CacheImageData(imageData: data, etag: etag)
	}
}
