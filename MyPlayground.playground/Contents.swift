import UIKit
import RxSwift

var str = "Hello, playground"

var a = BehaviorSubject(value: 1)
var b = BehaviorSubject(value: "one")
//"two", "tree", "four", "five", "six", "seven", "eight", "nine", "ten"

let disposable = Observable.combineLatest(a, b) { integer, string -> String in
    print(integer)
    print(string)
    return "\(integer) and \(string)"
}.subscribe({
    print($0)
})
a.onNext(2)
b.onNext("two")
a.onNext(3)
b.onNext("tree")
disposable.dispose()
