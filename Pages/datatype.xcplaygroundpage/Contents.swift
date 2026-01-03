//: [Previous](@previous)

import Foundation


var x = 1 + 2 // 표현식 (expression)
//할당 연산자

var num = 10
num %= 3 // %= 3으로 나눈 연산자가 뭐인지?
//복합 할당 연산자

let a = 10
let b = 5

let isEqual = a != b
print(isEqual)
//비교 연산자 참과 거짓으로 리턴

let isRating = true
let isCold = false
if isRating && isCold{
    print("두개 다 참이다")
}else if isRating || isCold{
    print("하나라도 참이다")
}else{
    print("둘다 참이 아니다")
}
//논리 연산자

let closedRange = 1...5 //1 부터 5까지 지정하는 연산자
for number in closedRange{
    print(number)
} //1부터 5까지 값을 순회하면서 출력

let halfOpenRange = 1..<5 //1부터 5미만의 값을 지정
for number in closedRange{
    print(number)
}

let index = [1,2,3,4,5,6,7,8,9]
let fromIndex = index[3...]
print(fromIndex)

for number in fromIndex{
    print(number)
}

//범위 연산자 반복적으로 할 때 사용 ... 이렇게 범위를 표현
//1. 닫힘 범위 연산자 ...
//2. 반 개방 범위 연산자
//3. 단방향 범위 연산자 배열을 순회할 때 어떤 인덱스 부터 순회할지 지정할때


let age = 25
let allowedDrinkAge = age >= 19 ? "Allowed" : "Not Allowed"

print(allowedDrinkAge)
//삼항 연산자
//condition ? true : false
//: [Next](@next)
