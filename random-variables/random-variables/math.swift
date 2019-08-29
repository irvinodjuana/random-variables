//
//  math.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-24.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import Foundation

class math {
    // Class for shared math utility functions
    
    static func factorial(_ n: Int) -> Double {
        // Returns n! (factorial of n) - uses double to handle larger ints
        if n == 0 {
            return 1
        }
        
        var product: Double = 1
        for i in 1...n {
            product *= Double(i)
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
}
