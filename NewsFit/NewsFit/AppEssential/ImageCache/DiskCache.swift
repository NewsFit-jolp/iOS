//
//  DiskCache.swift
//  Core
//
//  Created by jung on 10/17/24.
//

import Foundation

final actor DiskCache {
	/// DiskCache에 저장할 최대 이미지 갯수
	private let limitCount = 300
	private let fileManager: FileManager = .default
	
	func cacheImageData(for key: String) -> CacheImageData? {
		guard
			let filePath = path(for: key),
			fileManager.fileExists(atPath: filePath.path),
			let data = try? Data(contentsOf: filePath)
		else { return nil }
		
		return try? JSONDecoder().decode(CacheImageData.self, from: data)
	}
	
	func saveCacheImageData(_ data: CacheImageData, for key: String) {
		guard
			let filePath = path(for: key),
			!(fileManager.fileExists(atPath: filePath.path)),
			let data = try? JSONEncoder().encode(data)
		else { return }
		
		let cacheDirectory = filePath.deletingLastPathComponent()
		evictLeastRecentlyUsed(at: cacheDirectory)
		
		fileManager.createFile(
			atPath: filePath.path,
			contents: data,
			attributes: nil
		)
	}
}

// MARK: - Private Methods
private extension DiskCache {
	func path(for key: String) -> URL? {
		let docuemtnsURL = try? fileManager.url(
			for: .cachesDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		)
		
		if #available(iOS 16, *) {
			return docuemtnsURL?.appending(path: key)
		} else {
			return docuemtnsURL?.appendingPathComponent(key)
		}
	}
	
	func evictLeastRecentlyUsed(at path: URL) {
		do {
			let cacheFiles = try fileManager.contentsOfDirectory(
				at: path,
				includingPropertiesForKeys: [.contentAccessDateKey],
				options: .skipsHiddenFiles
			)
			
			guard cacheFiles.count >= limitCount else { return }
			
			var filesAndAttributes: [URL: Date] = [:]
			
			for fileURL in cacheFiles {
				let attributes = try fileURL.resourceValues(forKeys: [.contentAccessDateKey])
				let lastAccessDate = attributes.contentAccessDate ?? Date.distantPast
				filesAndAttributes[fileURL] = lastAccessDate
			}
			
			if let lastAccessImage = filesAndAttributes.sorted(by: { $0.value < $1.value }).first {
				try fileManager.removeItem(at: lastAccessImage.key)
			}
		} catch {
			print(error)
		}
	}
}
