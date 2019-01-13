import XCTest

class HeapTests: XCTestCase {
    func testRemove() {
        let heap = Heap(elements: [1,12,3,4,1,6,8,7], sort: >)

        var result: [Int] = []

        while let element = heap.remove() {
            result.append(element)
        }

        XCTAssert(result == [12,8,7,6,4,3,1,1])
    }

    func testNthMin() {
        let heap = Heap(elements: [3, 10, 18, 5, 21, 100], sort: <)

        let n = 3

        var result: Int?

        (0..<n).forEach { _ in
            result = heap.remove()
        }

        XCTAssert(result == 10)
    }

    func testBinaryTreeRepresentation() {
        let heap = Heap(elements: [21, 10, 18, 5, 3, 100, 1], sort: <)

        let node = heap.toBinaryTree()

        XCTAssert(node?.value == 1)
    }

    func testMergeTwoHeaps() {
        let heap1 = Heap(elements: [21, 10, 18, 5], sort: >)
        let heap2 = Heap(elements: [3, 100, 1], sort: <)

        heap1.merge(with: heap2)

        XCTAssert(heap1.elements.sorted() == [1,3,5,10,18,21,100])
    }

    func testArrayIsMinHeap() {
        let arr = [1,3,18,5,10,100,21]
        let heap = Heap(elements: arr, sort: <)

        XCTAssert(arr == heap.elements)
    }
}
