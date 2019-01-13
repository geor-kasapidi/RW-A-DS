import XCTest

class QueueTests: XCTestCase {
    func testBasicOperations() {
        let queue = Queue<Int>()

        XCTAssert(queue.toArray() == [])

        queue.enqueue(1)

        XCTAssert(queue.toArray() == [1])

        queue.dequeue()

        XCTAssert(queue.toArray() == [])

        queue.enqueue(2)
        queue.enqueue(3)
        queue.enqueue(4)

        XCTAssert(queue.toArray() == [4,3,2])
        XCTAssert(queue.peek == 2)

        queue.dequeue()

        XCTAssert(queue.toArray() == [4,3])

        queue.dequeue()
        queue.dequeue()

        XCTAssert(queue.toArray() == [])
        XCTAssert(queue.isEmpty)
    }

    func testReverse() {
        let queue = Queue<Int>()

        queue.enqueue(4)
        queue.enqueue(3)
        queue.enqueue(2)
        queue.enqueue(1)

        XCTAssert(queue.reversed().toArray() == [4,3,2,1])
    }
}
