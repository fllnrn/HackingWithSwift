//
//  Project39Tests.swift
//  Project39Tests
//
//  Created by Андрей Гавриков on 01.02.2022.
//

import XCTest
@testable import Project39

class Project39Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllWordsLoaded() {
        let playData = PlayData()
        XCTAssertEqual(playData.allWords.count, 18440, "all Words must be 18440")
    }
    
    func testWordCountsAreCorrect() {
        let playData = PlayData()
        XCTAssertEqual(playData.wordCounts.count(for:"home" ), 174, "Home does not appear 174 times")
        XCTAssertEqual(playData.wordCounts.count(for:"fun" ), 4, "Home does not appear 4 times")
        XCTAssertEqual(playData.wordCounts.count(for:"mortal" ), 41, "Home does not appear 41 times")
    }
    
    func testUserFilterWorks() throws {
        let playData = PlayData()
        
        playData.applyUserFilter("100")
        XCTAssertEqual(playData.filteredWords.count, 495)
        
        playData.applyUserFilter("1000")
        XCTAssertEqual(playData.filteredWords.count, 55)

        playData.applyUserFilter("10000")
        XCTAssertEqual(playData.filteredWords.count, 1)

        playData.applyUserFilter("test")
        XCTAssertEqual(playData.filteredWords.count, 56)

        playData.applyUserFilter("swift")
        XCTAssertEqual(playData.filteredWords.count, 7)

        playData.applyUserFilter("objective-c")
        XCTAssertEqual(playData.filteredWords.count, 0)
    }

    func testWordsLoadQuickly() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = PlayData()
            // Put the code you want to measure the time of here.
        }
    }

}
