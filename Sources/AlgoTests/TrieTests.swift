import XCTest

class TrieTests: XCTestCase {
    func testInsertContains() {
        let trie = Trie<String>()

        XCTAssert(!trie.contains("cute"))

        trie.insert("cute")

        XCTAssert(trie.contains("cute"))
    }

    func testInsertContainsRemove() {
        let trie = Trie<String>()

        trie.insert("cut")
        trie.insert("cute")

        XCTAssert(trie.contains("cut"))
        XCTAssert(trie.contains("cute"))
        XCTAssert(!trie.contains("cu"))

        trie.remove("cut")

        XCTAssert(!trie.contains("cut"))
        XCTAssert(trie.contains("cute"))
        XCTAssert(!trie.contains("cu"))
    }

    func testPrefix() {
        let trie = Trie<String>()
        trie.insert("car")
        trie.insert("card")
        trie.insert("care")
        trie.insert("cared")
        trie.insert("cars")
        trie.insert("carbs")
        trie.insert("carapace")
        trie.insert("cargo")
        trie.insert("cab")

        XCTAssert(trie.collections(startingWith: "car").sorted() == ["car", "card", "care", "cared", "cars", "carbs", "carapace", "cargo"].sorted())

        XCTAssert(trie.collections(startingWith: "care").sorted() == ["care", "cared"].sorted())
    }

    func testAllCollections() {
        let trie = Trie<String>()

        XCTAssert(trie.allCollections == [])

        trie.insert("my")
        trie.insert("name")
        trie.insert("is")
        trie.insert("john")

        XCTAssert(trie.allCollections.sorted() == ["my", "name", "is", "john"].sorted())
    }

    func testCount() {
        let trie = Trie<String>()

        XCTAssert(trie.count == 0)

        trie.insert("my")

        XCTAssert(trie.count == 1)

        trie.insert("name")

        XCTAssert(trie.count == 2)

        trie.remove("na")

        XCTAssert(trie.count == 2)

        trie.remove("name")

        XCTAssert(trie.count == 1)

        trie.remove("my")

        XCTAssert(trie.count == 0)
    }

    func testCount2() {
        let trie = Trie<String>()

        XCTAssert(trie.count == 0)

        trie.insert("abc")

        XCTAssert(trie.count == 1)

        trie.insert("abc")

        XCTAssert(trie.count == 1)
    }
}
