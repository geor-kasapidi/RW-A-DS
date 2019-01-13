import XCTest

class DijkstraTests: XCTestCase {
    func test1() {
        let graph = Graph<String, UInt>(vertices: ["A", "B", "C", "D", "E", "F", "G", "H"])

        graph.add(edge: 2, from: "H", to: "F", backToo: false)
        graph.add(edge: 5, from: "H", to: "G", backToo: false)
        graph.add(edge: 3, from: "G", to: "C", backToo: false)
        graph.add(edge: 2, from: "F", to: "A", backToo: false)
        graph.add(edge: 1, from: "A", to: "G", backToo: false)
        graph.add(edge: 9, from: "A", to: "F", backToo: false)
        graph.add(edge: 8, from: "A", to: "B", backToo: false)
        graph.add(edge: 3, from: "C", to: "B", backToo: false)
        graph.add(edge: 1, from: "C", to: "E", backToo: false)
        graph.add(edge: 8, from: "E", to: "C", backToo: false)
        graph.add(edge: 1, from: "E", to: "B", backToo: false)
        graph.add(edge: 2, from: "E", to: "D", backToo: false)
        graph.add(edge: 1, from: "B", to: "E", backToo: false)
        graph.add(edge: 3, from: "B", to: "F", backToo: false)

        print(graph)

        let result = graph.dijkstra(from: "A", maxDistance: UInt.max)

        XCTAssert(result["D"] == ["A", "G", "C", "E", "D"])
    }
}
