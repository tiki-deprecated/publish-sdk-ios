/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public class Title{
    private let channel: Channel
    
    public init(channel: Channel){
        self.channel = channel
    }
    
    public func create(
        ptr: String,
        tags: [Tag],
        description: String? = nil,
        origin: String? = nil,
        completion: ((TitleRecord?) -> Void)? = nil
    ) async throws -> TitleRecord? {
        let titleReq = ReqTitle(
            ptr: ptr,
            tags: tags,
            description: description,
            origin: origin
        )
        let rspTitle: RspTitle = try await channel.request(
            method: TrailMethod.TITLE_CREATE,
            request: titleReq) { rsp in
                let paybaleResp = RspTitle(from: rsp)
                return paybaleResp
            }
        let title = TitleRecord(from: rspTitle)
        completion?(title)
        return title
    }
    
    public func get(ptr: String, origin: String? = nil, completion: ((TitleRecord?) -> Void)? = nil) async throws -> TitleRecord? {
        let titleReq = ReqTitleGet(ptr: ptr, origin: origin)
        let rspTitle: RspTitle = try await channel.request(
            method: TrailMethod.TITLE_GET,
            request: titleReq) { rsp in
                let paybaleResp = RspTitle(from: rsp)
                return paybaleResp
            }
        let title = TitleRecord(from: rspTitle)
        completion?(title)
        return title
    }
    
    public func id(id: String, completion: ((TitleRecord?) -> Void)? = nil) async throws -> TitleRecord? {
        let titleReq = ReqTitleId(id: id)
        let rspTitle: RspTitle = try await channel.request(
            method: TrailMethod.TITLE_ID,
            request: titleReq) { rsp in
                let titlesResp = RspTitle(from: rsp)
                return titlesResp
            }
        let title = TitleRecord(from: rspTitle)
        completion?(title)
        return title
    }
}
