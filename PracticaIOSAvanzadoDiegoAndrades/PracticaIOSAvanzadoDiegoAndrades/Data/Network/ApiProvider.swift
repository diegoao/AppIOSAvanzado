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
    let host: URL = URL(string: "https://dragonball.keepcoding.education")!
    let token = "eyJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYiLCJ0eXAiOiJKV1QifQ.eyJpZGVudGlmeSI6IjdBQjhBQzRELUFEOEYtNEFDRS1BQTQ1LTIxRTg0QUU4QkJFNyIsImVtYWlsIjoiYmVqbEBrZWVwY29kaW5nLmVzIiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.Dxxy91hTVz3RTF7w1YVTJ7O9g71odRcqgD00gspm30s"
    
    func requestFor(endpoint: GokuEndpoints) -> URLRequest {
        switch endpoint {
        case .listHeroes, .listTransformaciones, .listLocations:
            var request = URLRequest.init(url: endpoint.urlFor(host: host))
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return request
        }
    }
}


class ApiProvider {
    
    private let session: URLSession
    private let requestProvider: RequestProvider
    
    init(session: URLSession = URLSession.shared, requestProvider: RequestProvider = RequestProvider()) {
        self.session = session
        self.requestProvider = requestProvider
    }
    
    func getHero( completion: @escaping (Result<[Hero], GokuApiError>) -> Void) {
        let request = requestProvider.requestFor(endpoint: .listHeroes)
        self.makeRequest(request: request, completion: completion)
    }
    
    func getTransformation(completion: @escaping ((Result<[Transformations], GokuApiError>) -> Void)) {
        let request = requestProvider.requestFor(endpoint: .listTransformaciones)
        self.makeRequest(request: request, completion: completion)
    }
    
    func getLocation(completion: @escaping ((Result<[Locations], GokuApiError>) -> Void)) {
        let request = requestProvider.requestFor(endpoint: .listTransformaciones)
        self.makeRequest(request: request, completion: completion)
    }
    
    func makeRequest<T: Decodable>( request: URLRequest, completion: @escaping ((Result<[T], GokuApiError>) -> Void)) {
        
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
                let responseData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.parsingData(error: error)))
            }
        }.resume()
        
    }
}
