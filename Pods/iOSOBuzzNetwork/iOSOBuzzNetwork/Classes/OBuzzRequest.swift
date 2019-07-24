
import Foundation

public enum OBuzzMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public class OBuzzRequest {
    
    public var request: URLRequest!
    
    public var baseUrl: URL?
    public var fullUrl: URL!

    public var httpMethod: OBuzzMethod!
    public var httpParams: OBuzzParams?
    
    public var documentParams : [String: Any]?
    public var filePathKey : String!
    public var docURL : URL?
    public init(baseUrl : URL,fullUrl : URL, httpMethod : OBuzzMethod, httpParams : OBuzzParams){
        self.baseUrl = baseUrl
        self.fullUrl = fullUrl
        self.httpMethod = httpMethod
        self.httpParams = httpParams
    }
    
    public init?(route: String? = nil, url: URL? = nil, method: OBuzzMethod = .get, params: OBuzzParams? = nil,isSetHeader : Bool) {
        //OBuzzNetworking.setServerUrl(url: URL(string: GlobalConstants.BaseURL))
        httpMethod = method
        httpParams = params
        if let requestBase = OBuzzConfiguration.shared.defaultUrl, let requestRoute = route {
            baseUrl = requestBase
            fullUrl = requestBase.appendingPathComponent(requestRoute)
        } else if let requestUrl = url {
            fullUrl = requestUrl
        } else {
            return nil
        }
        
        configureRequest(isSetHeader: isSetHeader)
    }
    public init?(url: URL? = nil, docURL : URL? = nil ,method: OBuzzMethod = .get, params: [String: Any]? = nil, filePathKey : String,isSetHeader : Bool) {
        //OBuzzNetworking.setServerUrl(url: URL(string: GlobalConstants.BaseURL))
        httpMethod = method
        documentParams = params
        self.docURL = docURL
        self.filePathKey = filePathKey
        if let requestUrl = url {
                fullUrl = requestUrl
            }
        
        configureRequestForDocUpload(isSetHeader: isSetHeader)
    }
    
    public func configureRequest(isSetHeader : Bool) {
        request = URLRequest(url: fullUrl)
        request.httpMethod = httpMethod.rawValue
        
        if let params = httpParams {
            request.httpBody = params.paramData
        }
        
       // if let _ = baseUrl {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if isSetHeader{
            OBuzzNetworking.setCustomAuthHeader()
            request.setValue("Bearer " + OBuzzConfiguration.shared.defaultAuthorizationHeader!, forHTTPHeaderField: "Authorization")
        }
        //}
    }
    public func configureRequestForDocUpload(isSetHeader : Bool) {
        request = URLRequest(url: fullUrl)
        request.httpMethod = httpMethod.rawValue
        // if let _ = baseUrl {
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //request.httpBody = params.paramData
        request.httpBody = createBodyWithParameters(docURL :self.docURL!,parameters: documentParams, filePathKey: filePathKey, boundary: boundary)
        if isSetHeader{
            OBuzzNetworking.setCustomAuthHeader()
            request.setValue("Bearer " + OBuzzConfiguration.shared.defaultAuthorizationHeader!, forHTTPHeaderField: "Authorization")
        }
        //}
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    func createBodyWithParameters(docURL : URL ,parameters: [String: Any]?, filePathKey: String?, boundary: String) -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(string: "--\(boundary)\r\n")
                body.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(string:"\(value)\r\n")
            }
        }
        
        let filename = docURL.lastPathComponent
        let mimetype = String().mimeTypeForPath(path : docURL.path)
        let data = try! Data(contentsOf: docURL)
        body.append(string:"--\(boundary)\r\n")
        body.append(string:"Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.append(string:"Content-Type: \(mimetype)\r\n\r\n")
        body.append(data)
        body.append(string:"\r\n")
        
        
        
        body.append(string:"--\(boundary)--\r\n")
        
        return body
    }
    
    public func execute(completion: @escaping (OBuzzResponse) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async{
            URLSession.shared.dataTask(with: self.request) { data, response, error in
                let response = OBuzzResponse(data: data, response: response, error: error)
                
                //  DispatchQueue.main.async {
                completion(response)
                // }
                
                // self.logDebug(data: data)
                }.resume()
        }
    }
    
    /*public func logDebug(data: Data?) {
        guard let debugData = data else { return }
        
        let responseString = String(data: debugData, encoding: String.Encoding.utf8) ?? ""
        
    }*/
    
}
