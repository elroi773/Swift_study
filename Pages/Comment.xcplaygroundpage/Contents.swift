//: [Previous](@previous)

import Foundation

var greeting = "Hello, Comment"

let quotation =  """
    The White Rabbit pur on his spectacles.     "Where shall I begin,
    please your Majesty?"  he asked. 
    
    "Begin at the beginning," the King said gravely, "and go on till you come to the end; then stop."
    """

let singleLineString = "These are the same."
let multiLineString = """
    These are the same
    """

let softWrappedQuotation = """
    The White Rabbiy put on his spectacles.     "Where shall I begin, \
    please your Majesty?" he asked.
    
    "Begin at the beginning," the King said gravely, "and go on \
    till you come to the end; then stop."
    """

//빈 문자열 초기화

var emptyString: String = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

//문자열 변경

var variableString = "Hello, World!"
variableString.append(" 🌍")
variableString.insert("👻", at: variableString.startIndex)
variableString.remove(at: variableString.index(before: variableString.endIndex))
//variableString에 이모지(🌍)를 뒤에 붙이고, 👻를 앞에 넣은 다음, 마지막 문자(🌍)를 삭제하는 코드
//: [Next](@next)
