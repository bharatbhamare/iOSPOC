
import Foundation

public class OBuzzResponse {
    
    public var success : Bool!
    public var statusCode = 0
    public var error: Error?
    public var data: Data?

    
    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.error = error
        self.data = data
        
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
        }
        
        success = statusCode == 200 && error == nil && data != nil ? true : false
    }
    
    public func jsonResults<T>(model: T.Type) -> T? {
        if !success { return nil }
        guard let responseData = data else { return nil }
        
        do {
            return try JSONSerialization.jsonObject(with: responseData) as? T
        } catch {
            return nil
        }
    }
    
    public func result<T: Decodable>(model: T.Type) -> T? {
        if !success { return nil }
        guard let responseData = data else { return nil }
        
        do {
            return try JSONDecoder().decode(model, from: responseData)
        } catch {
            return nil
        }
    }
    
}
