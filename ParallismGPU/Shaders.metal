//
//  Shaders.metal
//  ParallismGPU
//
//  Created by Mohammad Jeragh on 10/5/19.
//  Copyright © 2019 Mohammad Jeragh. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void kernel_main(device float* factors [[buffer(1)]],
                        uint pid [[thread_position_in_grid]]){
    
}
