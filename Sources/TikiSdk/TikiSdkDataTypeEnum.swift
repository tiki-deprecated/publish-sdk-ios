/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The type of data origin for an ownership registry.
public enum TikiSdkDataTypeEnum: String, Codable{
    case point = "data_point"
    case pool = "data_pool"
    case stream = "data_stream"
}