import XCTest

class StackTests: XCTestCase {
    func testBasicOperations() {
        let stack = Stack<Int>()

        XCTAssert(stack.toArray() == [])

        stack.push(1)

        XCTAssert(stack.toArray() == [1])

        stack.push(2)

        XCTAssert(stack.toArray() == [2, 1])

        stack.pop()

        XCTAssert(stack.toArray() == [1])

        stack.pop()

        XCTAssert(stack.toArray() == [])
    }
}
