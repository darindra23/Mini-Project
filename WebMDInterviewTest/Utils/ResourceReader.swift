import Foundation

public enum ReaderError: Error {
    case resourceNotFound
    case decodeError(String)
}

public final class ResourceReader {
    public static let shared = ResourceReader()
    private init() {}

    public func read<T: Decodable>(resource: String, model _: T.Type) -> Result<T, ReaderError> {
        guard let resourcePath = Bundle.main.path(forResource: resource, ofType: "json") else {
            return .failure(.resourceNotFound)
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: resourcePath), options: .mappedIfSafe)
            let result = try JSONDecoder().decode(T.self, from: data)

            return .success(result)

        } catch let DecodingError.keyNotFound(_, context) {
            return .failure(.decodeError(context.debugDescription))

        } catch let DecodingError.typeMismatch(_, context) {
            return .failure(.decodeError(context.debugDescription))

        } catch let DecodingError.valueNotFound(_, context) {
            return .failure(.decodeError(context.debugDescription))

        } catch {
            return .failure(.decodeError(error.localizedDescription))
        }
    }
}
