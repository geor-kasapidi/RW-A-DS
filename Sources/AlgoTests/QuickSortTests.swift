import XCTest

class QuickSortTests: XCTestCase {
    func testNaive() {
        let a = [5,7,5,4,1,3,6,7,9,2,2]

        let b = QuickSort.naive(a)

        XCTAssert(b == [1,2,2,3,4,5,5,6,7,7,9])
    }

    func testLomuto() {
        var a = [5,7,5,4,1,3,6,7,9,2,2]

        QuickSort.lomuto(&a)

        XCTAssert(a == [1,2,2,3,4,5,5,6,7,7,9])
    }

    func testHoare() {
        var a = [5,7,5,4,1,3,6,7,9,2,2]

        QuickSort.hoare(&a)

        XCTAssert(a == [1,2,2,3,4,5,5,6,7,7,9])
    }

    func testHoareIteratively() {
        var a = [5,7,5,4,1,3,6,7,9,2,2]

        QuickSort.hoareIteratively(&a)

        XCTAssert(a == [1,2,2,3,4,5,5,6,7,7,9])
    }

    func testMedian3() {
        var a = [5,7,5,4,1,3,6,7,9,2,2]

        QuickSort.lomuto3median(&a)

        XCTAssert(a == [1,2,2,3,4,5,5,6,7,7,9])
    }

    func testDutchFlag() {
        var a = [5,7,5,4,1,3,6,7,9,2,2]

        QuickSort.dutchFlag(&a)

        XCTAssert(a == [1,2,2,3,4,5,5,6,7,7,9])
    }
}
