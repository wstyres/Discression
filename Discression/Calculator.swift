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
    var twosComplimentToInt: Double = 0;
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
        result.twosComplimentToInt = number.twosComplimentToInt
        
        return result
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
    var twosComplimentToInt: Double { return Double(Int16(bitPattern: UInt16(self, radix: 16) ?? 0))}
    
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
