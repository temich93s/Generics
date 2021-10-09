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
