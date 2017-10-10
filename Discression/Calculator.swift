//
//  Calculator.swift
//  Discression
//
//  Created by Wilson Styres on 10/8/17.
//  Copyright © 2017 Wilson Styres. All rights reserved.
//

import Cocoa
import Foundation
import Accelerate

struct Result {
    var hexToInt: Int = 0;
    var hexToDouble: Double = 0;
    var hexToBinary: String = "0";
    var decimalToHex: String = "0";
    var decimalToBinary: String = "0";
    var binaryToInt: Int = 0;
    var binaryToDouble: Double = 0;
    var binaryToHex: String = "0";
    var complementToInt: Int = 0;
}

class Calculator: NSObject {
    
    class func calculateAll(number: String) -> Result {
        var result: Result = Result()
        result.hexToInt = number.hexToInt
        result.hexToDouble = number.hexToDouble
        result.hexToBinary = number.hexToBinary
        result.decimalToHex = number.decimalToHex
        result.decimalToBinary = number.decimalToBinary
        result.binaryToInt = number.binaryToInt
        result.binaryToDouble = number.binaryToDouble
        result.binaryToHex = number.binaryToHex
        result.complementToInt = number.complementToInt
        
        return result
    }
    
    class func invertBinary(binary: String) -> String {
        var invertedString: String = ""
        
        for character in binary {
            if character == "0" {
                invertedString += "1"
            }
            else if character == "1" {
                invertedString += "0"
            }
        }
        
        return invertedString
    }
    
 class func addBinary(a:String, b:String) -> String {
        guard let _a = Int(a, radix: 2), let _b = Int(b, radix: 2) else { return "0" }
        
        return String(_a + _b, radix: 2)
    }
    
}

extension String {
    //Various converters
    var hexToInt: Int    { return Int(strtoul(self, nil, 16)) }
    var hexToDouble: Double { return Double(strtoul(self, nil, 16)) }
    var hexToBinary: String { return String(hexToInt, radix: 2) }
    var decimalToHex: String { return String(Int(self) ?? 0, radix: 16) }
    var decimalToBinary: String { return String(Int(self) ?? 0, radix: 2) }
    var binaryToInt: Int    { return Int(strtoul(self, nil, 2)) }
    var binaryToDouble: Double { return Double(strtoul(self, nil, 2)) }
    var binaryToHex: String { return String(binaryToInt, radix: 16) }
    
    
    
    //Takes two's complement binary string and converts it into an int
    var complementToInt: Int {
        if self.characters.first == "0" {
            return binaryToInt
        }
        else if self.characters.first == "1" {
            let invertedBinary = Calculator.invertBinary(binary: self)
            print(invertedBinary)
            let additiveComplement = Calculator.addBinary(a: invertedBinary, b: "1")
            print(additiveComplement)
            var result = additiveComplement.binaryToInt
            result.negate()
            return result
        }
        else {
            return 0
        }
    }
    
    //Convert half precision binary string into a Float
    var halfPrecisionBinaryToFloat: Float {
        let unsignedHex = UInt16(binaryToHex, radix: 16)
        var input: [UInt16] = [ unsignedHex! ]
        var output = [Float](repeating: 0, count: 1)
        var bufferFloat16 = vImage_Buffer(data: &input, height: 1, width: UInt(1), rowBytes: 2)
        var bufferFloat32 = vImage_Buffer(data: &output, height: 1, width: UInt(1), rowBytes: 4)
        vImageConvert_Planar16FtoPlanarF(&bufferFloat16, &bufferFloat32, 0)
        
        return output[0]
    }
    
    //Convert a Float into a half precision binary string
    var floatToHalfPrecisionBinary: String {
        var input: [Float] = [ Float(self)! ]
        var output = [UInt16](repeating: 0, count: 1)
        var bufferFloat32 = vImage_Buffer(data: &input, height: 1, width: UInt(1), rowBytes: 4)
        var bufferFloat16 = vImage_Buffer(data: &output, height: 1, width: UInt(1), rowBytes: 2)
        vImageConvert_PlanarFtoPlanar16F(&bufferFloat32, &bufferFloat16, 0)
        
        var binary = String(output[0]).decimalToHex.hexToBinary
        while binary.count < 16 {
            binary = "0" + binary
        }
        return binary
    }
}
