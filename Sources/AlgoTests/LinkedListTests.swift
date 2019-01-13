import XCTest

class LinkedListTests: XCTestCase {
    func testPush() {
        var list = LinkedList<Int>()

        XCTAssert(list.toArray() == [])

        list.push(3)

        XCTAssert(list.toArray() == [3])

        list.push(2)

        XCTAssert(list.toArray() == [2,3])

        list.push(1)

        XCTAssert(list.toArray() == [1,2,3])
    }

    func testAppend() {
        var list = LinkedList<Int>()

        XCTAssert(list.toArray() == [])

        list.append(1)

        XCTAssert(list.toArray() == [1])

        list.append(2)

        XCTAssert(list.toArray() == [1,2])

        list.append(3)

        XCTAssert(list.toArray() == [1,2,3])
    }

    func testInsertAt() {
        var list = LinkedList<Int>()

        list.append(1)
        list.append(2)
        list.append(3)

        list.insert(100, at: 0)

        XCTAssert(list.toArray() == [100,1,2,3])

        list.insert(100, at: 4)

        XCTAssert(list.toArray() == [100,1,2,3,100])

        list.insert(100, at: 2)

        XCTAssert(list.toArray() == [100,1,100,2,3,100])
    }

    func testPop() {
        var list = LinkedList<Int>()

        list.append(1)
        list.append(2)
        list.append(3)

        XCTAssert(list.pop() == 1)
        XCTAssert(list.toArray() == [2,3])

        XCTAssert(list.pop() == 2)
        XCTAssert(list.toArray() == [3])

        XCTAssert(list.pop() == 3)
        XCTAssert(list.toArray() == [])
    }

    func testRemoveLast() {
        var list = LinkedList<Int>()

        list.append(1)
        list.append(2)
        list.append(3)

        XCTAssert(list.removeLast() == 3)
        XCTAssert(list.toArray() == [1,2])

        XCTAssert(list.removeLast() == 2)
        XCTAssert(list.toArray() == [1])

        XCTAssert(list.removeLast() == 1)
        XCTAssert(list.toArray() == [])
    }

    func testRemoveAt() {
        var list = LinkedList<Int>()

        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(5)
        list.append(6)

        XCTAssert(list.remove(at: 3) == 4)
        XCTAssert(list.toArray() == [1,2,3,5,6])

        XCTAssert(list.remove(at: 3) == 5)
        XCTAssert(list.toArray() == [1,2,3,6])

        XCTAssert(list.remove(at: 3) == 6)
        XCTAssert(list.toArray() == [1,2,3])

        XCTAssert(list.remove(at: 0) == 1)
        XCTAssert(list.toArray() == [2,3])

        XCTAssert(list.remove(at: Int.max) == 3)
        XCTAssert(list.toArray() == [2])

        XCTAssert(list.remove(at: 0) == 2)
        XCTAssert(list.toArray() == [])
    }

    func testCOW() {
        var list1 = LinkedList<Int>()

        list1.append(1)
        list1.append(2)
        list1.append(3)

        var list2 = list1

        list2.append(4)

        XCTAssert(list1.toArray() == [1,2,3])
        XCTAssert(list2.toArray() == [1,2,3,4])

        var list3 = list2

        list3.remove(at: 2)

        XCTAssert(list1.toArray() == [1,2,3])
        XCTAssert(list2.toArray() == [1,2,3,4])
        XCTAssert(list3.toArray() == [1,2,4])
    }

    func testReversed() {
        var list1 = LinkedList<Int>()

        list1.append(1)
        list1.append(2)
        list1.append(3)

        let list2 = list1.reversed()

        XCTAssert(list1.toArray() == [1,2,3])
        XCTAssert(list2.toArray() == [3,2,1])
    }

    func testLength() {
        var list = LinkedList<Int>()

        XCTAssert(list.length == 0)

        list.append(1)
        XCTAssert(list.length == 1)

        list.append(2)
        XCTAssert(list.length == 2)

        list.append(3)
        XCTAssert(list.length == 3)

        XCTAssert(list.remove(at: list.length / 2) == 2)
    }

    func testRemoveAll() {
        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(2)
            list.append(1)

            list.removeAll(1)

            XCTAssert(list.toArray() == [2])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(1)
            list.append(1)

            list.removeAll(1)

            XCTAssert(list.toArray() == [])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(1)
            list.append(1)

            list.removeAll(2)

            XCTAssert(list.toArray() == [1,1,1])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)

            list.removeAll(1)

            XCTAssert(list.toArray() == [])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(2)
            list.append(3)

            list.removeAll(3)

            XCTAssert(list.toArray() == [1,2])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(2)
            list.append(3)

            list.removeAll(2)

            XCTAssert(list.toArray() == [1,3])
        }

        do {
            var list = LinkedList<Int>()

            list.append(1)
            list.append(2)
            list.append(2)
            list.append(3)

            list.removeAll(2)

            XCTAssert(list.toArray() == [1,3])
        }
    }

    func testSortedMerge() {
        do {
            var list1 = LinkedList<Int>()

            list1.append(1)

            var list2 = LinkedList<Int>()

            list2.append(2)

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [1,2])
        }

        do {
            let list1 = LinkedList<Int>()

            var list2 = LinkedList<Int>()

            list2.append(2)

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [2])
        }

        do {
            var list1 = LinkedList<Int>()

            list1.append(1)

            let list2 = LinkedList<Int>()

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [1])
        }

        do {
            var list1 = LinkedList<Int>()

            list1.append(1)
            list1.append(3)

            var list2 = LinkedList<Int>()

            list2.append(2)
            list2.append(4)

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [1,2,3,4])
        }

        do {
            var list1 = LinkedList<Int>()

            list1.append(1)
            list1.append(4)

            var list2 = LinkedList<Int>()

            list2.append(2)
            list2.append(3)

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [1,2,3,4])
        }

        do {
            var list1 = LinkedList<Int>()

            list1.append(1)
            list1.append(4)
            list1.append(10)
            list1.append(11)

            var list2 = LinkedList<Int>()

            list2.append(1)
            list2.append(2)
            list2.append(3)
            list2.append(6)

            let list3 = list1.sortedMergeWith(list: list2)

            XCTAssert(list3.toArray() == [1,1,2,3,4,6,10,11])
        }
    }
}
