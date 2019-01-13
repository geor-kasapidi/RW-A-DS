import XCTest

class SortTests: XCTestCase {
    func testBubbleSort() {
        var arr = [4,7,1,3,9,11]

        arr.bubbleSort(>)

        XCTAssert(arr == [11,9,7,4,3,1])
    }

    func testSelectionSort() {
        var arr = [4,7,1,3,9,11]

        arr.selectionSort(>)

        XCTAssert(arr == [11,9,7,4,3,1])
    }

    func testInsertionSort() {
        var arr = [4,7,1,3,9,11]

        arr.insertionSort(>)

        XCTAssert(arr == [11,9,7,4,3,1])
    }

    func testCustomOrderFunction() {
        var arr = [1,5,6,2,3,1,8,1]

        arr.insertionSort { (x, y) -> Bool in
            y == 1
        }

        XCTAssert(arr.suffix(3) == [1,1,1])
    }

    func testFindFirstDuplicate() {
        var arr = [1,3,2,4,2,3]

        arr.insertionSort(<)

        var duplicate: Int?

        for i in arr.indices {
            let j = arr.index(after: i)

            if i < arr.endIndex && j < arr.endIndex {
                if arr[i] == arr[j] {
                    duplicate = arr[i]

                    break
                }
            }
        }

        XCTAssert(duplicate == 2)
    }

    func testCustomReverse() {
        do {
            var arr = [1,2,3,4,5]
            arr.customReverse()
            XCTAssert(arr == [5,4,3,2,1])
        }

        do {
            var arr = [1,2,3,4]
            arr.customReverse()
            XCTAssert(arr == [4,3,2,1])
        }
    }

    func testMidIndex() {
        do {
            let arr = [1,2,3,4,5]

            XCTAssert(arr.midIndex == 2)
        }

        do {
            let arr = [1,2,3,4]

            XCTAssert(arr.midIndex == 2)
        }

        do {
            let arr = [1,2,3,4,5,6,7]

            XCTAssert(arr.midIndex == 3)
        }

        do {
            let arr: [Int] = []

            XCTAssert(arr.midIndex == arr.endIndex)
        }
    }

    func testMergeSort() {
        let arr = [1,7,4,6,2,3,9,11,4]

        let result = arr.mergeSorted()

        XCTAssert(result == [1,2,3,4,4,6,7,9,11])
    }

    func testMerge() {
        let arr1 = [1,4,7,9]
        let arr2 = [2,6]

        XCTAssert(MergeSort.merge(arr1, arr2) == [1,2,4,6,7,9])
    }

    func testRadixSort() {
        var arr = [7,100,45,782, 11]

        arr.radixSort()

        XCTAssert(arr == [7,11,45,100,782])
    }

    func testLexicographicalRadixSort() {
        var arr = [5000, 1345, 1300, 4590, 4400, 9990] // [500, 1345, 13, 459, 44, 999]

        arr.radixSort()

        XCTAssert(arr == [1300, 1345, 4400, 4590, 5000, 9990])
    }

    func testHeapSort() {
        let arr = [4,7,1,3,9,11]

        let result = arr.heapSorted(>)

        XCTAssert(result == [11,9,7,4,3,1])
    }
}
