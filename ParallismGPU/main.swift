//
//  main.swift
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

import Foundation
import MetalKit


let row : uint = 3
var column : uint = 4
var array  = Array(repeating: Array<Float>(repeating: 0, count: Int(column)), count: Int(row))

let start = DispatchTime.now() // <<<<<<<<<< Start time

var device = MTLCreateSystemDefaultDevice()!
var commandQueue = device.makeCommandQueue()!
var library = device.makeDefaultLibrary()
let commandBuffer = commandQueue.makeCommandBuffer()
let computeEncoder = commandBuffer?.makeComputeCommandEncoder()

var computeFunction = library?.makeFunction(name: "kernel_main")!
var computePipelineState = try! device.makeComputePipelineState(function: computeFunction!)
var matrixBuffer = device.makeBuffer(bytes: &array, length: Int(row*column) * MemoryLayout<Float>.stride, options: [])

computeEncoder?.pushDebugGroup("settingup")
computeEncoder?.setComputePipelineState(computePipelineState)
computeEncoder?.setBuffer(matrixBuffer, offset: 0, index: 0)
computeEncoder?.setBytes(&column, length: MemoryLayout<uint>.stride, index: 1)

let threadsPerThreadGrid = MTLSizeMake(Int(row * column), 1, 1)
computeEncoder?.dispatchThreadgroups(threadsPerThreadGrid, threadsPerThreadgroup: MTLSizeMake(1, 1, 1))

computeEncoder?.endEncoding()
computeEncoder?.popDebugGroup()
commandBuffer?.commit()
commandBuffer?.waitUntilCompleted()

let end = DispatchTime.now()   // <<<<<<<<<<   end time

let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

print("Time to execute: \(timeInterval) seconds")

let contents = matrixBuffer?.contents()
let pointer = contents?.bindMemory(to: Float.self, capacity: Int(row*column))

let result = (0..<Int(row*column)).map{
    pointer?.advanced(by: $0).pointee
}

print("test")
