//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

class Title{
    private channel: Channel
    
    init(channel: Channel){
        self.channel = channel
    }
    
    /// Creates a new TitleRecord, or retrieves an existing one.
    ///
    /// Use this function to create a new TitleRecord for a given Pointer Record (ptr), or retrieve an existing one if it already exists.
    /// - Parameters:
    ///     - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key. Learn more about selecting good pointer records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
    ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`. Follow a reverse-DNS syntax,
    ///     i.e. com.myco.myapp.
    ///     - tags: A list of metadata tags included in the TitleRecord describing the asset, for your use in record search and filtering. Learn
    ///     more about adding tags at https://docs.mytiki.com/docs/adding-tags.
    ///     - description: A short, human-readable, description of the TitleRecord as a future reminder.
    /// - Returns: The created or retrieved TitleRecord.
    public static func title(ptr: String, origin: String? = nil, tags: [TitleTag]? = [], description: String? = nil) async throws -> TitleRecord {
        
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitle(
                    ptr: ptr,
                    tags: tags ?? [],
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
                    method: CoreMethod.title,
                    request: reqTitle,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspTitle.title!
    }
    
    /// Retrieves the TitleRecord with the specified ID, or `nil` if the record is not found.
    ///
    /// Use this method to retrieve the metadata associated with an asset identified by its TitleRecord ID.
    /// - Parameters
    ///  - id: The ID of the TitleRecord to retrieve.
    ///  - origin: An optional override of the default origin specified in initialization. Follow a reverse-DNS syntax, i.e.
    ///  com.myco.myapp`.
    ///  - Returns: The TitleRecord with the specified ID, or `nil` if the record is not found.
    public static func getTitle(id: String, origin: String? = nil) async throws -> TitleRecord?{
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitleGet(
                    id: id,
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
                    method: CoreMethod.getTitle,
                    request: reqTitle,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspTitle.title
    }
    
}
