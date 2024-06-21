//
//  CoreDataCafeStorageTests.swift
//  HomeFeatureTests
//
//  Created by Jaehun Lee on 6/4/24.
//

import XCTest
@testable import HomeFeature
import CoreData

final class CoreDataCafeStorageTests: XCTestCase {
    var sut: CoreDataCafeStorage!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataCafeStorage(coreDataStorage: CoreDataStorage(inMemory: true))
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_addOneCafeWithOneCategorizedTag() async throws {
        // Given
        let tagsOfCafe: Set<Tag> = [
            Tag(name: "조용함", category: .mood)
        ]
        
        let cafeToAdd = Cafe(
            id: "1234",
            name: "스타벅스",
            address: "경기도 안양시 동안구 시민대로 271",
            phone: "031-123-1234",
            coord: Coord(longitude: 1.11, latitude: 2.22),
            placeURL: "https://example.com/1234",
            tags: tagsOfCafe
        )
        
        // When
        try await sut.addCafe(cafeToAdd)
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, 1)
        XCTAssertEqual(fetchedCafes[0], cafeToAdd)
    }
    
    func test_addOneCafeWithOneCustomTag() async throws {
        // Given
        let tagsOfCafe: Set<Tag> = [
            Tag(name: "상쾌함", category: nil)
        ]
        
        let cafeToAdd = Cafe(
            id: "1234",
            name: "스타벅스",
            address: "경기도 안양시 동안구 시민대로 271",
            phone: "031-123-1234",
            coord: Coord(longitude: 1.11, latitude: 2.22),
            placeURL: "https://example.com/1234",
            tags: tagsOfCafe
        )
        
        // When
        try await sut.addCafe(cafeToAdd)
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, 1)
        XCTAssertEqual(fetchedCafes[0], cafeToAdd)
    }
    
    func test_addOneCafeWithOneCategorizedTagTheOtherCustomTag() async throws {
        // Given
        let tagsOfCafe: Set<Tag> = [
            Tag(name: "조용함", category: .mood),
            Tag(name: "상쾌함", category: nil)
        ]
        
        let cafeToAdd = Cafe(
            id: "1234",
            name: "스타벅스",
            address: "경기도 안양시 동안구 시민대로 271",
            phone: "031-123-1234",
            coord: Coord(longitude: 1.11, latitude: 2.22),
            placeURL: "https://example.com/1234",
            tags: tagsOfCafe
        )
        
        // When
        try await sut.addCafe(cafeToAdd)
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, 1)
        XCTAssertEqual(fetchedCafes[0], cafeToAdd)
    }
    
    func test_addTwoCafesWithSameTag() async throws {
        // Given
        let tagsOfCafe: Set<Tag> = [
            Tag(name: "상쾌함", category: nil),
        ]
        
        let cafesToAdd = [
            Cafe(
                id: "1234",
                name: "스타벅스",
                address: "경기도 안양시 동안구 시민대로 271",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/1234",
                tags: tagsOfCafe
            ),
            Cafe(
                id: "2345",
                name: "이디야",
                address: "경기도 안양시 동안구 시민대로 272",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/2345",
                tags: tagsOfCafe
            )
        ]
        
        // When
        for cafe in cafesToAdd {
            try await sut.addCafe(cafe)
        }
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(Set(fetchedCafes), Set(cafesToAdd))
    }
    
    func test_addTwoCafesWithSameTags() async throws {
        // Given
        let tagsOfCafe: Set<Tag> = [
            Tag(name: "상쾌함", category: nil),
            Tag(name: "넓음", category: .cafeSize)
        ]
        
        let cafesToAdd = [
            Cafe(
                id: "1234",
                name: "스타벅스",
                address: "경기도 안양시 동안구 시민대로 271",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/1234",
                tags: tagsOfCafe
            ),
            Cafe(
                id: "2345",
                name: "이디야",
                address: "경기도 안양시 동안구 시민대로 272",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/2345",
                tags: tagsOfCafe
            )
        ]
        
        // When
        for cafe in cafesToAdd {
            try await sut.addCafe(cafe)
        }
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(Set(fetchedCafes), Set(cafesToAdd))
    }
    
    func test_addTwoCafesWhichHasTagIntersection() async throws {
        // Given
        let tagsOfCafe1: Set<Tag> = [
            Tag(name: "조용함", category: .mood),
            Tag(name: "넓음", category: .cafeSize),
            Tag(name: "상쾌함", category: nil)
        ]
        
        let tagsOfCafe2: Set<Tag> = [
            Tag(name: "시끄러움", category: .mood),
            Tag(name: "좁음", category: .cafeSize),
            Tag(name: "상쾌함", category: nil)
        ]
        
        let cafesToAdd = [
            Cafe(
                id: "1234",
                name: "스타벅스",
                address: "경기도 안양시 동안구 시민대로 271",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/1234",
                tags: tagsOfCafe1
            ),
            Cafe(
                id: "2345",
                name: "이디야",
                address: "경기도 안양시 동안구 시민대로 272",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/2345",
                tags: tagsOfCafe2
            )
        ]
        
        // When
        for cafe in cafesToAdd {
            try await sut.addCafe(cafe)
        }
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(Set(fetchedCafes), Set(cafesToAdd))
    }
    
    func test_addTwoCafesWhichHasTagsIntersection() async throws {
        // Given
        let tagsOfCafe1: Set<Tag> = [
            Tag(name: "조용함", category: .mood),
            Tag(name: "넓음", category: .cafeSize),
            Tag(name: "상쾌함", category: nil)
        ]
        
        let tagsOfCafe2: Set<Tag> = [
            Tag(name: "조용함", category: .mood),
            Tag(name: "좁음", category: .cafeSize),
            Tag(name: "상쾌함", category: nil)
        ]
        
        let cafesToAdd = [
            Cafe(
                id: "1234",
                name: "스타벅스",
                address: "경기도 안양시 동안구 시민대로 271",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/1234",
                tags: tagsOfCafe1
            ),
            Cafe(
                id: "2345",
                name: "이디야",
                address: "경기도 안양시 동안구 시민대로 272",
                phone: "031-123-1234",
                coord: Coord(longitude: 1.11, latitude: 2.22),
                placeURL: "https://example.com/2345",
                tags: tagsOfCafe2
            )
        ]
        
        // When
        for cafe in cafesToAdd {
            try await sut.addCafe(cafe)
        }
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(Set(fetchedCafes), Set(cafesToAdd))
    }
    
    func test_addTwoCafesWithSameID() async throws {
        // Given
        let cafesToAdd = [
            Cafe(
                id: "1234",
                 name: "",
                 address: "",
                 phone: "",
                 coord: Coord(longitude: .zero, latitude: .zero),
                 placeURL: "https://example.com/1234",
                 tags: []
            ),
            Cafe(
                id: "1234",
                 name: "",
                 address: "",
                 phone: "",
                 coord: Coord(longitude: .zero, latitude: .zero),
                 placeURL: "https://example.com/1234",
                 tags: []
            )
        ]
        
        let expectedCafesCount = 1
        
        // When
        for cafe in cafesToAdd {
            try await sut.addCafe(cafe)
        }
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, expectedCafesCount)
    }
    
    func test_deleteCafe() async throws {
        // Given
        let cafes = [
            Cafe(
                id: "1234",
                name: "",
                address: "",
                phone: "",
                coord: Coord(longitude: .zero, latitude: .zero),
                placeURL: "https://example.com/1234",
                tags: [
                    Tag(name: "쾌적함", category: .congestion)
                ]
            ),
            Cafe(
                id: "2345",
                name: "",
                address: "",
                phone: "",
                coord: Coord(longitude: .zero, latitude: .zero),
                placeURL: "https://example.com/1234",
                tags: [
                    Tag(name: "쾌적함", category: .congestion)
                ]
            )
        ]
        
        for cafe in cafes {
            try await sut.addCafe(cafe)
        }
        
        let expectedCafesCount = 1
        
        // When
        try await sut.deleteCafe(cafes[0])
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, expectedCafesCount)
        XCTAssertEqual(fetchedCafes[0], cafes[1])
    }
    
    func test_updateCafe() async throws {
        // Given
        let cafes = [
            Cafe(
                id: "1234",
                name: "",
                address: "",
                phone: "",
                coord: Coord(longitude: .zero, latitude: .zero),
                placeURL: "https://example.com/1234",
                tags: [
                    Tag(name: "쾌적함", category: .congestion)
                ]
            ),
            Cafe(
                id: "2345",
                name: "",
                address: "",
                phone: "",
                coord: Coord(longitude: .zero, latitude: .zero),
                placeURL: "https://example.com/1234",
                tags: [
                    Tag(name: "쾌적함", category: .congestion)
                ]
            )
        ]
        
        let cafeToUpdate = Cafe(
            id: "1234",
            name: "Changed!",
            address: "",
            phone: "",
            coord: Coord(longitude: .zero, latitude: .zero),
            placeURL: "https://example.com/1234",
            tags: [
                Tag(name: "시원함", category: nil)
            ]
        )
        
        for cafe in cafes {
            try await sut.addCafe(cafe)
        }
        
        // When
        try await sut.updateCafe(cafeToUpdate)
        
        // Then
        let fetchedCafes = try await sut.fetchCafes()
        XCTAssertEqual(fetchedCafes.count, 2)
        XCTAssertTrue(fetchedCafes.contains(cafeToUpdate))
    }
}
