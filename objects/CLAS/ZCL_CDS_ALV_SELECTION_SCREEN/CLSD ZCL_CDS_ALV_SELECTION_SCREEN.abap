class-pool .
*"* class pool for class ZCL_CDS_ALV_SELECTION_SCREEN

*"* local type definitions
include ZCL_CDS_ALV_SELECTION_SCREEN==ccdef.

*"* class ZCL_CDS_ALV_SELECTION_SCREEN definition
*"* public declarations
  include ZCL_CDS_ALV_SELECTION_SCREEN==cu.
*"* protected declarations
  include ZCL_CDS_ALV_SELECTION_SCREEN==co.
*"* private declarations
  include ZCL_CDS_ALV_SELECTION_SCREEN==ci.
endclass. "ZCL_CDS_ALV_SELECTION_SCREEN definition

*"* macro definitions
include ZCL_CDS_ALV_SELECTION_SCREEN==ccmac.
*"* local class implementation
include ZCL_CDS_ALV_SELECTION_SCREEN==ccimp.

class ZCL_CDS_ALV_SELECTION_SCREEN implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_CDS_ALV_SELECTION_SCREEN implementation
