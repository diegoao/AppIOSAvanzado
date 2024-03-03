//
//  ApiProvider.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import Foundation

enum GokuEndpoints {
    case listHeroes
    case listTransformaciones
    case listLocations
    
    func urlFor(host: URL) -> URL {
        switch self {
        case .listHeroes:
            return host.appendingPathComponent("/heros/all")
        case .listTransformaciones:
            return host.appendingPathComponent("/heros/tranformations")
        case .listLocations:
            return host.appendingPathComponent("/heros/locations")
        }
    }
}


enum GokuApiError: Error, CustomStringConvertible {
    
    case server(error: Error)
    case statusCode(code: Int)
    case noData
    case parsingData(error: Error)
    
    var description: String {
        switch self {
        case .server(let error):
            return error.localizedDescription
        case .statusCode(let code):
            return "Received error status code \(code)"
        case .noData:
            return "No Data received from service"
        case .parsingData(let error):
            return "Error parsing data \(error.localizedDescription)"
        }
    }
}

struct RequestProvider {
    private var secureData: SecureDataProtocol
    init(secureData: SecureDataProtocol = SecureData()) {
        self.secureData = secureData
    }
    let host: URL = URL(string: "https://dragonball.keepcoding.education/api")!
  
    func requestFor(endpoint: GokuEndpoints, token: String, idtransformation: String? = nil, idLocation: String? = nil) -> URLRequest {
        let token = token
        let idtransformation = idtransformation

        switch endpoint {
        case .listHeroes, .listTransformaciones, .listLocations:
            var request = URLRequest.init(url: endpoint.urlFor(host: host))
            // Indicamos el metodo post
            request.httpMethod = HTTPMethods.post
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            struct HeroRequest: Encodable {
                let name: String
            }
            struct TransformationRequest: Encodable {
                let id: String
            }
            struct LocationRequest: Encodable {
                let id: String
            }
            
            if case.listHeroes = endpoint {
                let heroRequest = HeroRequest(name: "")
                request.httpBody = try? JSONEncoder().encode(heroRequest)
            }
            if case.listTransformaciones = endpoint {
                let heroRequest = TransformationRequest(id: idtransformation ?? "")
                request.httpBody = try? JSONEncoder().encode(heroRequest)
            }
            if case.listLocations = endpoint {
                let heroRequest = LocationRequest(id: idLocation ?? "")
                request.httpBody = try? JSONEncoder().encode(heroRequest)
            }
            
         
            return request
        }
    }
}


class ApiProvider {
    
    private var secureData: SecureDataProtocol
    private let session: URLSession
    private let requestProvider: RequestProvider
    
    init(session: URLSession = URLSession.shared, requestProvider: RequestProvider = RequestProvider(), secureData: SecureDataProtocol = SecureData()) {
        self.session = session
        self.requestProvider = requestProvider
        self.secureData = secureData
    }
    
    func getHero(completion: @escaping (Result<[Hero], GokuApiError>) -> Void) {
        let request = requestProvider.requestFor(endpoint: .listHeroes, token:secureData.getToken() ?? "")
        self.makeRequest(request: request, completion: completion)
        
    }
    
    func getTransformation(id: String, completion: @escaping ((Result<[Transformation], GokuApiError>) -> Void)) {
        let request = requestProvider.requestFor(endpoint: .listTransformaciones, token:secureData.getToken() ?? "", idtransformation: id)
        self.makeRequest(request: request, completion: completion)
    }
    
    func getLocation(id: String, completion: @escaping ((Result<[Location], GokuApiError>) -> Void)) {
        let request = requestProvider.requestFor(endpoint: .listLocations, token:secureData.getToken() ?? "",
            idLocation: id)
        self.makeRequest(request: request, completion: completion)
    }
    
    func makeRequest<T: Decodable>( request: URLRequest, completion: @escaping ((Result<[T], GokuApiError>) -> Void)) {
        print(request)
        
        session.dataTask(with: request) { data, response, error in
            
            if let error {
                completion(.failure(.server(error: error)))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               statusCode != 200 {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                var responseData = try JSONDecoder().decode([T].self, from: data)
                if !responseData.isEmpty, T.self == Hero.self {
                    responseData.removeLast()
                }
                
                completion(.success(responseData))
            } catch {
                completion(.failure(.parsingData(error: error)))
            }
        }.resume()
        
    }
}
