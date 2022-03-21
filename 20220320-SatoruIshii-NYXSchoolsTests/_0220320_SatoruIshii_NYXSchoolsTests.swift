//
//  _0220320_SatoruIshii_NYXSchoolsTests.swift
//  20220320-SatoruIshii-NYXSchoolsTests
//
//  Created by Satoru Ishii on 3/20/22.
//

import XCTest
import Combine
@testable import _0220320_SatoruIshii_NYXSchools

class _0220320_SatoruIshii_NYXSchoolsTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// NYCSchools API Test - Fetch, Publish, Subscribe
    func testNYCScrools() throws {
        /// for Asyncronize Testing
        let expectation = expectation(description: "Fetch the NYC Schools")
        ///  Schools API Fetcher
        let nycSchoolsFetcher = NYCSchoolsFetcher()
        var schoolsCount = 0
        nycSchoolsFetcher.nycSchools()
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case .failure:
                        XCTFail("testFetchFailure")
                    case .finished:
                        XCTAssert(true, "receiveCompletion finished")
                        print("receiveCompletion finished")
                        expectation.fulfill()
                        break
                    }
                },
                receiveValue: { nycSchoolsResponses in
                    schoolsCount = nycSchoolsResponses.count
                    XCTAssert(schoolsCount > 0, "Schools get \(schoolsCount)")
                    print("receiveValue")
                })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

    /// SAT Results API Test - Fetch, Publish, Subscribe
    func testSATResults() throws {
        /// for Asyncronize Testing
        let expectation = expectation(description: "Fetch the SAT Results")
        /// SAT Results API Fetcher
        let satResultsFetcher = SATResultsFetcher()
        /// Special Test Data
        let dbn = "17K548" /// Brooklyn School for Music & Theatre dbn
        let schoolName = "BROOKLYN SCHOOL FOR MUSIC & THEATRE"
        satResultsFetcher.satResults(dbn: dbn)
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case .failure:
                        XCTFail("Test SATResults Failure")
                    case .finished:
                        XCTAssert(true, "Test SAT Results ReceiveCompletion finished")
                        print("SAT Results receiveCompletion finished")
                        expectation.fulfill()
                        break
                    }
                },
                receiveValue: { satResultsResponse in
                    let resDbn = satResultsResponse[0].dbn
                    XCTAssert(resDbn == dbn)
                    let name = satResultsResponse[0].school_name
                    XCTAssert(name == schoolName)
                    print("Test SAT Results ReceiveValue \(name)")
                })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }
}
