//
//  PracticaIOSAvanzadoDiegoAndradesTests.swift
//  PracticaIOSAvanzadoDiegoAndradesTests
//
//  Created by Macbook Pro on 23/2/24.
//

import XCTest
@testable import PracticaIOSAvanzadoDiegoAndrades

final class PracticaIOSAvanzadoDiegoAndradesTests: XCTestCase {
    

    var sut: StoreDataProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = StoreDataProvider(storageType: .inMemory)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - TEST CLASE INSERTAR HEROE
    func test_insertHero() {
        //Given
        let initialCount = sut.fetchHeroes().count
        XCTAssertEqual(initialCount, 0)
        
        //When
        let heroe = Hero(id: "1", name: "Diego", description: "Probando Descripción", photo: "foto1", favorite: true)
        sut.insert(heroes: [heroe])
        
        //Then
        
        let finalCount = sut.fetchHeroes().count
        XCTAssertEqual(finalCount, 1)
        let newHeroe = sut.fetchHeroes().first
        XCTAssertEqual(heroe.id, newHeroe?.id)
        XCTAssertEqual(heroe.name, newHeroe?.name)
        XCTAssertEqual(heroe.description, newHeroe?.heroDescription)
        XCTAssertEqual(heroe.photo, newHeroe?.photo)
    }
    
    // MARK: - TEST CLASE INSERTAR TRANSFORMACION
    func test_inserTransformation() {
        //Given
        let initialCount = sut.fetchTransformations().count
        XCTAssertEqual(initialCount, 0)
        
        
        //When
        let transformation = Transformation(id: "2",
                                            name: "Pedro",
                                            description: "Profesor",
                                            photo: "foto2",
                                            hero: nil)
        sut.insert(transformations: [transformation])
        
        //Then
        
        let finalcount = sut.fetchTransformations().count
        XCTAssertEqual(finalcount, 1)
        let newTransformation = sut.fetchTransformations().first
        XCTAssertEqual(transformation.id, newTransformation?.id)
        XCTAssertEqual(transformation.name, newTransformation?.name)
        XCTAssertEqual(transformation.description, newTransformation?.informacion)
        XCTAssertEqual(transformation.photo, newTransformation?.photo)
        
    }
    
    // MARK: - TEST CLASE INSERTAR LOCALIZACION
    func test_inserLocation(){
        //Given
        let initialCount = sut.fetchLocations().count
        XCTAssertEqual(initialCount, 0)
        
        //When
        
        let location = Location(id: "3",
                                latitude: "200",
                                longitude: "1500",
                                date: "08:00 PM",
                                hero: nil)
        sut.insert(locations: [location])
        
        //Then
        
        let finalCount = sut.fetchLocations().count
        XCTAssertEqual(finalCount, 1)
        let newLocation = sut.fetchLocations().first
        XCTAssertEqual(location.id, newLocation?.id)
        XCTAssertEqual(location.latitude, newLocation?.latitude)
        XCTAssertEqual(location.longitude, newLocation?.longitude)
        XCTAssertEqual(location.date, newLocation?.date)
    }
    
    // MARK: - TEST CLASE ACTUALIZAR HEROE
    func test_updateHeroes(){
        
        //Given
        let newHeroe = Hero(id: "1", name: "Diego", description: "Probando Descripción", photo: "foto1", favorite: true)
        sut.insert(heroes: [newHeroe])
        
        
        //When
        let newHeroe2 = Hero(id: "1", name: "DiegoUpdate", description: "Probando Descripción", photo: "foto1", favorite: true)
        sut.insert(heroes: [newHeroe2])
        
        
        //Then
        let heroe = sut.fetchHeroes().first
        XCTAssertEqual(heroe?.name, newHeroe2.name)
        let finalCount = sut.fetchHeroes().count
        XCTAssertEqual(finalCount, 1)
        
    }
    
    // MARK: - Eliminar bbdd
    func test_clearBBDD() {
        //GIVEN
        let heroe = Hero(id: "1", name: "Diego", description: "Probando Descripción", photo: "foto1", favorite: true)
        sut.insert(heroes: [heroe])
        let transformation = Transformation(id: "2",
                                            name: "Pedro",
                                            description: "Profesor",
                                            photo: "foto2",
                                            hero: nil)
        sut.insert(transformations: [transformation])
        let location = Location(id: "3",
                                latitude: "200",
                                longitude: "1500",
                                date: "08:00 PM",
                                hero: nil)
        sut.insert(locations: [location])
        
        XCTAssertEqual(sut.fetchHeroes().count, 1)
        XCTAssertEqual(sut.fetchTransformations().count, 1)
        XCTAssertEqual(sut.fetchLocations().count, 1)
        
        //when
        sut.clearBBDD()
        
        
        //Then
        XCTAssertEqual(sut.fetchHeroes().count, 0)
        XCTAssertEqual(sut.fetchTransformations().count, 0)
        XCTAssertEqual(sut.fetchLocations().count, 0)
        
        
        
    }
    
    
}
