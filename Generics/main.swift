//
//  main.swift
//  Generics
//
//  Created by 2lup on 09.10.2021.
//

import Foundation

print("Hello, World!")


//MARK: Проблема, которую решают универсальные шаблоны
print("\n//Проблема, которую решают универсальные шаблоны")

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Выведет "someInt is now 107, and anotherInt is now 3"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someString = "+3"
var anotherString = "+107"
swapTwoStrings(&someString, &anotherString)
print("someInt is now \(someString), and anotherInt is now \(anotherString)")

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someDouble = 3.0
var anotherDouble = 107.0
swapTwoDoubles(&someDouble, &anotherDouble)
print("someInt is now \(someDouble), and anotherInt is now \(anotherDouble)")


//MARK: Универсальные функции
print("\n//Универсальные функции")

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

someInt = 3
anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
print(someInt, anotherInt)
// someInt равен 107, а anotherInt равен 3
 
var someString1 = "hello"
var anotherString1 = "world"
swapTwoValues(&someString1, &anotherString1)
print(someString1, anotherString1)
// someString равна "world", а anotherString равна "hello"


//MARK: Универсальные типы
print("\n//Универсальные типы")

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
print(stackOfStrings)
stackOfStrings.push("uno")
print(stackOfStrings)
stackOfStrings.push("dos")
print(stackOfStrings)
stackOfStrings.push("tres")
print(stackOfStrings)
stackOfStrings.push("cuatro")
print(stackOfStrings)
// stack содержит 4 строки

let fromTheTop = stackOfStrings.pop()
print(stackOfStrings)
// fromTheTop равен "cuatro", а stack содержит 3 строки


//MARK: Расширяем универсальный тип
print("\n//Расширяем универсальный тип")

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is: \(topItem).")
}
// Выведет "The top item on the stack is tres."


//MARK: Ограничение типа в действии
print("\n//Ограничение типа в действии")

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Выведет "The index of llama is 2"

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
print(doubleIndex as Any)
// doubleIndex опциональный Int не имеющий значения, потому что значения 9.3 нет в массиве
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
print(stringIndex as Any)
// stringIndex опциональный Int равный 2


//MARK: Связанные типы в действии
print("\n//Связанные типы в действии")

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack1: Container {
    // исходная реализация IntStack
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // удовлетворение требований протокола Container
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

var some = IntStack1()
print(some)
some.append(1)
some.append(12)
print(some)
some.push(14)
print(some)
print(some.pop())
print(some)
print(some[1])
print(some.items)

struct Stack1<Element>: Container {
    // исходная реализация Stack<Element>
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // удовлетворение требований протокола Container
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

var some1 = Stack1<String>()
print(some1)
some1.append("+3")
some1.append("+13")
print(some1)
some1.push("+16")
print(some1)
print(some1.pop())
print(some1)
print(some1[1])
print(some1.items)


//MARK: Расширение существующего типа для указания связанного типа
print("\n//Расширение существующего типа для указания связанного типа")

extension Array: Container {}


//MARK: Добавление ограничений в связанный тип
print("\n//Добавление ограничений в связанный тип")

protocol Container1 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


//MARK: Использование протокола в ограничениях связанного типа
print("\n//Использование протокола в ограничениях связанного типа")

struct Stack2: Container2 {
    // исходная реализация IntStack
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // удовлетворение требований протокола Container
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

protocol Container2 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

protocol SuffixableContainer2: Container2 {
    associatedtype Suffix: SuffixableContainer2 where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack2: SuffixableContainer2 {
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Определено, что Suffix является Stack.
}
var stackOfInts = Stack2()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
print(stackOfInts)

var suffix = stackOfInts.suffix(2)
// suffix содержит 20 и 30
print(suffix)

stackOfInts.items.append(40)
print(stackOfInts)
