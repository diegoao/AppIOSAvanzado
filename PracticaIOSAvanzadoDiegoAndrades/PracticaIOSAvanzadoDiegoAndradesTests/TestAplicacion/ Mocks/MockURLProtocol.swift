//
//  MockURLProtocol.swift
//  PracticaIOSAvanzadoDiegoAndradesTests
//
//  Created by Macbook Pro on 3/3/24.
//

import Foundation


import Foundation


//Clase helper que nos permite capturar las llamadas de la api y devolverlle los datos que nos interese
// para  hacer testing de las llamadas a servicios y modelo de datos.

class MockURLProtocol: URLProtocol {
    
    //Asignamos un error cuando queremos hacer un test de error
    static var error: Error?
    //clousure donde hace llegar a las llamadas de la api el response y data  necesarios para los tests
    static var handler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    //No hacemos validaciones, siempre puede iniciar la request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    //Devolvemos la request tal cual nos llega sin modificar
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override func startLoading() {
        // Sitenemos valor en error lo devolvemos y no continuamos.
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        // Si no tenemos error, pero tampoco handler, no podemos continuar es un error
        guard let handler = MockURLProtocol.handler else {
            fatalError("Handler not provided")
        }
        
        do {
            // recuperamos del handler del test el response y el data y se lo enviamos a l a llamada al servicio
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            //Si recibimos un error del handler lo devolvemos
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    // Clase  que es obligatorio sobre escribirla pero que no tenemos que hacer nada en ella
    override func stopLoading() { }
    
    
    //Helper que no crea un httpURL response  con un status code que queramos hacer test
    // por defecto 200 si no se indica.
    static func urlResponseFor(url: URL, statusCode: Int = 200) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: ["Content-Type" : "application/json"])
        
    }
    
    
}
