//
//  ApiProviderTest.swift
//  PracticaIOSAvanzadoDiegoAndradesTests
//
//  Created by Macbook Pro on 3/3/24.
//

import XCTest

@testable import PracticaIOSAvanzadoDiegoAndrades

final class ApiProviderTest: XCTestCase {
    
    let host =  URL(string: "https://dragonball.keepcoding.education/api")!
    let token = "expectedToken"
    
    var sut: ApiProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Sobre la configuración ephemeral del sistema, añadimos nuesta clase de MockURLProtocol
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        // Creamos la sesión con la configuración
        let session = URLSession(configuration: configuration)
        // Creamos ApiProvider con la sessión creada y que usa MockURLProtocol para capturar las llamadas de red
        sut = ApiProvider(session: session)
    }
    
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        MockURLProtocol.handler = nil
        MockURLProtocol.error = nil
    }
    
    func test_getHeroes() {
        
        //given
        let expectedToken = Hero(id: "1985A353-157F-4C0B-A789-FD5B4F8DABDB",
                                 name: "Mr. Satán",
                                 description: "Mr. Satán es un charlatán fanfarrón, capaz de manipular a las masas. Pero en realidad es cobarde cuando se da cuenta que no puede contra su adversario como ocurrió con Androide 18 o Célula. Siempre habla más de la cuenta, pero en algún momento del combate empieza a suplicar. Androide 18 le ayuda a fingir su victoria a cambio de mucho dinero. Él acepta el trato porque no podría soportar que todo el mundo le diera la espalda por ser un fraude.",
                                 photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/dragon-ball-satan.jpg?width=300",
                                 favorite: false)
        
        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("/heros/all"))
            
            let mockUrl = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "MockHero", withExtension: "json"))
            let data = try Data(contentsOf: mockUrl)
            
            let response = try XCTUnwrap(MockURLProtocol.urlResponseFor(url: url))
            
            
            
            return(response, data)
        }
        
        //WHEN
        let expectation = expectation(description: "Load heros")
        sut.getHero { result in
            switch result{
            case.success(let heros):
                XCTAssertEqual(heros.count, 15)
                let SeconHero = heros[1]
                XCTAssertEqual(SeconHero.name, expectedToken.name)
            case.failure(_):
                XCTFail("Waiting for success")
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.4)
        
    }
    
    func test_getHeroesError(){
        //Given
        MockURLProtocol.error = NSError(domain:"io.keepcoding.loadhero", code: -1000)
        
        //WHEN
        let expectation = expectation(description: "hero load server error")
        sut.getHero { result in
            switch result{
            case.success(_):
                XCTFail("Waiting for error")
            case.failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.4)
        
    }
        
    func test_getHeroesErrorStatusCode() {
        //given
        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("/heros/all"))
            let response = try XCTUnwrap(MockURLProtocol.urlResponseFor(url: url, statusCode: 401))
            return(response, Data())
        }
        
        //WHEN
        let expectation = expectation(description: "Hero error status code")
        sut.getHero { result in
            switch result{
            case.success(_):
                XCTFail("Waiting for success")
            case.failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.description, "Received error status code \(401)")
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.4)
    }
    
    
    func test_getTrasnformation() {
        
        //given
        let expectedToken = Transformation(id: "6E1B907C-EB3A-45BA-AE03-44FA251F64E9",
                                           name: "4. Super Saiyajin 3",
                                           description: "Esta transformación es exclusiva de los videojuegos, ya que hemos podido verlo en Dragon Ball Heroes, Dragon Battlers, Raging Blast y su posterior secuela.",
                                           photo: "https://areajugones.sport.es/wp-content/uploads/2019/07/super-saiyajin-3-vegeta-a-maxima-potencia_1680217-1024x576.jpg.webp",
                                           hero: nil)
        
        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("/heros/tranformations"))
            
            let mockUrl = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "MockTransformation", withExtension: "json"))
            let data = try Data(contentsOf: mockUrl)
            
            let response = try XCTUnwrap(MockURLProtocol.urlResponseFor(url: url))
            
            
            
            return(response, data)
        }
        
        //WHEN
        let expectation = expectation(description: "Load transformation")
        sut.getTransformation(id: "D1C73353-5256-4AA1-B125-944D5C00A78B") { result in
            switch result{
            case.success(let transfor):
                XCTAssertEqual(transfor.count, 8)
                let firstTransfor = transfor.first
                XCTAssertEqual(firstTransfor?.name, expectedToken.name)
            case.failure(_):
                XCTFail("Waiting for success")
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.4)
        
    }
    
    
    
    
    func test_getLocation() {
        
        //given
        let expectedToken = Location(id: "610246EB-CD5B-48AF-9A5D-6C9609A76684",
                                     latitude: "41.909986",
                                     longitude: "12.3959148",
                                     date: "2022-09-11T00:00:00Z",
                                     hero: nil)
        
        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("/heros/locations"))
            
            let mockUrl = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "MockLocation", withExtension: "json"))
            let data = try Data(contentsOf: mockUrl)
            
            let response = try XCTUnwrap(MockURLProtocol.urlResponseFor(url: url))
            
            
            
            return(response, data)
        }
        
        //WHEN
        let expectation = expectation(description: "Load Location")
        sut.getLocation(id: "610246EB-CD5B-48AF-9A5D-6C9609A76684") { result in
            switch result{
            case.success(let Location):
                XCTAssertEqual(Location.count, 1)
                let firstLocation = Location.first
                XCTAssertEqual(firstLocation?.latitude, expectedToken.latitude)
            case.failure(_):
                XCTFail("Waiting for success")
            }
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.4)
        
    }
    
    
    
    


}
