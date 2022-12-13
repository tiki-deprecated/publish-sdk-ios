/// The type of data origin for an ownership registry.
public enum TikiSdkDataType: String, Codable{
    case point = "data_point"
    case pool = "data_pool"
    case stream = "data_stream"
}
