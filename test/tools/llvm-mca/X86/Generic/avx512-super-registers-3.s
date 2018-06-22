# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -timeline -timeline-max-iterations=2 < %s | FileCheck %s

  vmulps  %zmm0, %zmm1, %zmm2
  vaddps  %xmm16, %xmm17, %xmm2
  vmulps  %ymm2, %ymm3, %ymm4
  vaddps  %xmm4, %xmm18, %xmm6
  vmulps  %xmm6, %xmm19, %xmm4
  vaddps  %xmm4, %xmm20, %xmm0

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      600
# CHECK-NEXT: Total Cycles:      318
# CHECK-NEXT: Dispatch Width:    4
# CHECK-NEXT: IPC:               1.89
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     1.00                        vmulps	%zmm0, %zmm1, %zmm2
# CHECK-NEXT:  1      3     1.00                        vaddps	%xmm16, %xmm17, %xmm2
# CHECK-NEXT:  1      5     1.00                        vmulps	%ymm2, %ymm3, %ymm4
# CHECK-NEXT:  1      3     1.00                        vaddps	%xmm4, %xmm18, %xmm6
# CHECK-NEXT:  1      5     1.00                        vmulps	%xmm6, %xmm19, %xmm4
# CHECK-NEXT:  1      3     1.00                        vaddps	%xmm4, %xmm20, %xmm0

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -     3.00   3.00    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vmulps	%zmm0, %zmm1, %zmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     vaddps	%xmm16, %xmm17, %xmm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vmulps	%ymm2, %ymm3, %ymm4
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     vaddps	%xmm4, %xmm18, %xmm6
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vmulps	%xmm6, %xmm19, %xmm4
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     vaddps	%xmm4, %xmm20, %xmm0

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          0123456

# CHECK:      [0,0]     DeeeeeER  .    .    .    ..   vmulps	%zmm0, %zmm1, %zmm2
# CHECK-NEXT: [0,1]     DeeeE--R  .    .    .    ..   vaddps	%xmm16, %xmm17, %xmm2
# CHECK-NEXT: [0,2]     D===eeeeeER    .    .    ..   vmulps	%ymm2, %ymm3, %ymm4
# CHECK-NEXT: [0,3]     D========eeeER .    .    ..   vaddps	%xmm4, %xmm18, %xmm6
# CHECK-NEXT: [0,4]     .D==========eeeeeER .    ..   vmulps	%xmm6, %xmm19, %xmm4
# CHECK-NEXT: [0,5]     .D===============eeeER   ..   vaddps	%xmm4, %xmm20, %xmm0
# CHECK-NEXT: [1,0]     .D==================eeeeeER   vmulps	%zmm0, %zmm1, %zmm2
# CHECK-NEXT: [1,1]     .DeeeE--------------------R   vaddps	%xmm16, %xmm17, %xmm2
# CHECK-NEXT: [1,2]     . D==eeeeeE---------------R   vmulps	%ymm2, %ymm3, %ymm4
# CHECK-NEXT: [1,3]     . D=======eeeE------------R   vaddps	%xmm4, %xmm18, %xmm6
# CHECK-NEXT: [1,4]     . D==========eeeeeE-------R   vmulps	%xmm6, %xmm19, %xmm4
# CHECK-NEXT: [1,5]     . D===============eeeE----R   vaddps	%xmm4, %xmm20, %xmm0

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     2     10.0   0.5    0.0       vmulps	%zmm0, %zmm1, %zmm2
# CHECK-NEXT: 1.     2     1.0    1.0    11.0      vaddps	%xmm16, %xmm17, %xmm2
# CHECK-NEXT: 2.     2     3.5    0.0    7.5       vmulps	%ymm2, %ymm3, %ymm4
# CHECK-NEXT: 3.     2     8.5    0.0    6.0       vaddps	%xmm4, %xmm18, %xmm6
# CHECK-NEXT: 4.     2     11.0   0.0    3.5       vmulps	%xmm6, %xmm19, %xmm4
# CHECK-NEXT: 5.     2     16.0   0.0    2.0       vaddps	%xmm4, %xmm20, %xmm0
