//
//  math.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-24.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import Foundation

class math {
    // Class for shared math functions
    
    static func factorial(_ n: Int) -> Double {
        // Returns: n! (factorial of n) as double
        // Requires: n >= 0
        if n == 0 {
            return 1
        }
        
        var product: Double = 1
        for i in 1...n {
            product *= Double(i)
        }
        return product
    }
    
    static func doubleFactorial(_ n: Int) -> Double {
        // Returns: n!! the double factorial or semifactorial of n
        // Requires: n >= -1 (not complete implementation)
        if n <= 0 {
            return 1
        }
        var start: Double = 0.0
        var product: Double = 1.0
        
        if n % 2 == 0 {
            start = 2.0
        } else {
            start = 1.0
        }
        
        while (start <= Double(n)) {
            product *= start
            start += 2.0
        }
        
        return product
    }
    
    static func choose(n: Int, k: Int) -> Double {
        // Returns binomial coefficient n choose k
        let numerator = factorial(n)
        let denominator = factorial(n - k) * factorial(k)
        return numerator / denominator
    }
    
    static func ln(_ x: Double) -> Double {
        // Returns natural log of x
        return log(x) / log(exp(1))
    }
    
    static func gamma(_ x: Double) -> Double {
        // Returns: gamma function of x
        // Requires: x is positive and x is an integer or half-integer
        if (x <= 0) {
            return -1 // invalid input
        }
        let rem = x.remainder(dividingBy: 1.0)
        
        if rem == 0.0 {
            return factorial(Int(x) - 1)
        } else if rem == 0.5 || rem == -0.5  {
            return sqrt(Double.pi) * doubleFactorial(Int(2.0 * x) - 2) / pow(2, x - 0.5)
        } else {
            return -1 // invalid input
        }
    }
}

// extension for rounding Double values
extension Double {
    func roundToPlace(_ places: Int) -> Double {
        let div = pow(10.0, Double(places))
        return (self * div).rounded() / div
    }
}
