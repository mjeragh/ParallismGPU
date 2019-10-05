//
//  main.swift
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

import Foundation
import MetalKit

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

guard let computeFunction = library?.makeFunction(name: "kernel_main") else{
    fatalError("Shader Unavailable")
}

try! device.makeComputePipelineState(function: computeFunction)



