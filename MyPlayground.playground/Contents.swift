import UIKit
import RxSwift

var str = "Hello, playground"

var a = Observable<Int>.from([1,2,3,4,5,6,7,8,9, 10])

a.subscribe({
print("subscribe on \($0)")
}).dispose()

