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
