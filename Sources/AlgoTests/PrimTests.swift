import XCTest

class PrimTests: XCTestCase {
    func test1() {
        let graph = Graph<Int, UInt>(vertices: [1,2,3,4,5,6])

        graph.add(edge: 6, from: 1, to: 2, backToo: true)
        graph.add(edge: 5, from: 1, to: 4, backToo: true)
        graph.add(edge: 3, from: 5, to: 2, backToo: true)
        graph.add(edge: 5, from: 5, to: 6, backToo: true)
        graph.add(edge: 2, from: 6, to: 4, backToo: true)
        graph.add(edge: 1, from: 3, to: 1, backToo: true)
        graph.add(edge: 5, from: 3, to: 4, backToo: true)
        graph.add(edge: 4, from: 3, to: 6, backToo: true)
        graph.add(edge: 6, from: 3, to: 5, backToo: true)
        graph.add(edge: 5, from: 3, to: 2, backToo: true)

        print(graph)

        let result = graph.prim(from: 2, maxDistance: UInt.max)!
        let sum = result.totalSum(undirected: true)

        print(result)

        XCTAssert(sum == 15)
    }

    func test2() {
        let graph = Graph<String, UInt>(vertices: ["A", "B", "C", "D", "E"])

        graph.add(edge: 21, from: "A", to: "C", backToo: true)
        graph.add(edge: 3, from: "A", to: "D", backToo: true)
        graph.add(edge: 4, from: "E", to: "C", backToo: true)
        graph.add(edge: 12, from: "E", to: "D", backToo: true)
        graph.add(edge: 2, from: "B", to: "A", backToo: true)
        graph.add(edge: 6, from: "B", to: "C", backToo: true)
        graph.add(edge: 2, from: "B", to: "E", backToo: true)
        graph.add(edge: 8, from: "B", to: "D", backToo: true)

        let result = graph.prim(from: "B", maxDistance: UInt.max)!

        print(result, result.totalSum(undirected: true))
    }
}
