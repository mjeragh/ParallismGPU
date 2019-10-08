//
//  main.swift
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

import Foundation
import MetalKit

let row = 30000
let column = 40000
var array  = Array(repeating: Array<Float>(repeating: 0, count: column), count: row)


var device :  MTLDevice!
guard let device = MTLCreateSystemDefaultDevice() else {
    fatalError("GPU Unavailable")
}
var commandQueue = device.makeCommandQueue()!
var library = device.makeDefaultLibrary()
let commandBuffer = commandQueue.makeCommandBuffer()
let computeEncoder = commandBuffer?.makeComputeCommandEncoder()
var computePipelineState: MTLComputePipelineState!
var computeFunction: MTLFunction!
var matrixBuffer: MTLBuffer!

guard let computeFunction = library?.makeFunction(name: "kernel_main") else{
    fatalError("Shader Unavailable")
}

try! device.makeComputePipelineState(function: computeFunction)
matrixBuffer = device.makeBuffer(bytes: array, length: array.count * MemoryLayout<Float>.stride, options: [])

computeEncoder?.setComputePipelineState(computePipelineState)
computeEncoder?.setBuffer(matrixBuffer, offset: 0, index: 1)


