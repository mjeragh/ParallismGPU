//
//  main.swift
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

import Foundation
import MetalKit

let row : uint = 3000
var column : uint = 4000
var array  = Array(repeating: Array<Float>(repeating: 0, count: Int(column)), count: Int(row))


var device = MTLCreateSystemDefaultDevice()!
var commandQueue = device.makeCommandQueue()!
var library = device.makeDefaultLibrary()
let commandBuffer = commandQueue.makeCommandBuffer()
let computeEncoder = commandBuffer?.makeComputeCommandEncoder()

var computeFunction = library?.makeFunction(name: "kernel_main")!
var computePipelineState = try! device.makeComputePipelineState(function: computeFunction!)
var matrixBuffer = device.makeBuffer(bytes: array, length: array.count * MemoryLayout<Float>.stride, options: [])
computeEncoder?.pushDebugGroup("settingup")
computeEncoder?.setComputePipelineState(computePipelineState)
computeEncoder?.setBuffer(matrixBuffer, offset: 0, index: 0)
computeEncoder?.setBytes(&column, length: MemoryLayout<uint>.stride, index: 1)

let threadsPerThreadGrid = MTLSizeMake(Int(row * column), 1, 1)
computeEncoder?.dispatchThreadgroups(threadsPerThreadGrid, threadsPerThreadgroup: MTLSizeMake(1, 1, 1))

computeEncoder?.endEncoding()
computeEncoder?.popDebugGroup()
commandBuffer?.commit()

for i in 0..<Int(3){
    
    for j in 0..<Int(4){
        print(array[i][j]," ")
    }
        
}

