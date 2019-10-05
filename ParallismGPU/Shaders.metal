//
//  Shaders.metal
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void kernel_main(device MTLQuadTessellationFactorsHalf* factors [[buffer(2)]],
uint pid [[thread_position_in_grid]],
constant float3  &camera_position [[ buffer(3)]],
constant float4x4 &modelMatrix    [[ buffer(4)]],
constant float3* control_points   [[ buffer(5)]]){
    
}
