import UIKit

var greeting = "Hello, playground"

func myPow(_ x: Double, _ n: Int) -> Double {
    
    if (n == 1) {
        return x
    } else if (n == -1) {
        return 1 / x
    }
    
    if n == 0 {
        return 1
    }
    
    var result : Double = 0
    
    if n % 2 != 0 {
        result = n < 0 ? 1 / myPow(x * x, (abs(n) - 1)/2) * x : myPow(x * x, (abs(n) - 1)/2) * x
        return result
    }
    
    result = n < 0 ? 1 / myPow(x * x, n/2) : myPow(x * x, n/2)
    return result
}

print("ini dari Bawah ", myPow(2, -2) == 1/4)


