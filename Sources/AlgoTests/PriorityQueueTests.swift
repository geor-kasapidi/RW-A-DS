import XCTest

private struct Person: Equatable {
    let name: String
    let age: Int
    let isMilitary: Bool

    static func hasHigherPriority(person: Person, than other: Person) -> Bool {
        if person.isMilitary && !other.isMilitary {
            return true
        }

        if !person.isMilitary && other.isMilitary {
            return false
        }

        return person.age > other.age
    }
}

class PriorityQueueTests: XCTestCase {
    func testHeapBasedPriorityQueue() {
        let queue = HeapBasedPriorityQueue<Int>(sort: >)

        [1,12,3,4,1,6,8,7].forEach(queue.enqueue)

        var result: [Int] = []

        while let element = queue.dequeue() {
            result.append(element)
        }

        XCTAssert(result == [12,8,7,6,4,3,1,1])
    }

    func testArrayBasedPriorityQueue() {
        let queue = ArrayBasedPriorityQueue<Int>(sort: >)

        [1,12,3,4,1,6,8,7].forEach(queue.enqueue)

        var result: [Int] = []

        while let element = queue.dequeue() {
            result.append(element)
        }

        XCTAssert(result == [12,8,7,6,4,3,1,1])
    }
}
