import XCTest

class BinarySearchTests: XCTestCase {
    func testSingleIndex1() {
        let arr = [1,2,3,4,5,6,7,8,9]

        XCTAssert(arr.binarySearchIndex(of: 5) == 4)
    }

    func testSingleIndex2() {
        let arr = [23,44,100,121]

        XCTAssert(arr.binarySearchIndex(of: 44) == 1)
    }

    func testSingleIndex3() {
        let arr = [23,44,100,121,500,800]

        XCTAssert(arr.binarySearchIndex(of: 800) == arr.endIndex - 1)
    }

    func testIndices1() {
        let arr = [1,2,3,4,5,6]

        XCTAssert(arr.binarySearchIndices(of: 3) == 2..<3)
    }

    func testIndices2() {
        let arr = [1,2,3,4,5,6]

        XCTAssert(arr.binarySearchIndices(of: 8) == nil)
    }

    func testIndices3() {
        let arr = [1,2,3,3,3,3,4,5,6]

        XCTAssert(arr.binarySearchIndices(of: 3) == 2..<6)
    }

    func testIndices4() {
        let arr = [3,3,3,3,3,3]

        XCTAssert(arr.binarySearchIndices(of: 3) == arr.indices)
    }
}
