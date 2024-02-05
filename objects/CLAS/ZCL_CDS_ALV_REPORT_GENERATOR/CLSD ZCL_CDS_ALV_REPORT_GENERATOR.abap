class-pool .
*"* class pool for class ZCL_CDS_ALV_REPORT_GENERATOR

*"* local type definitions
include ZCL_CDS_ALV_REPORT_GENERATOR==ccdef.

*"* class ZCL_CDS_ALV_REPORT_GENERATOR definition
*"* public declarations
  include ZCL_CDS_ALV_REPORT_GENERATOR==cu.
*"* protected declarations
  include ZCL_CDS_ALV_REPORT_GENERATOR==co.
*"* private declarations
  include ZCL_CDS_ALV_REPORT_GENERATOR==ci.
endclass. "ZCL_CDS_ALV_REPORT_GENERATOR definition

*"* macro definitions
include ZCL_CDS_ALV_REPORT_GENERATOR==ccmac.
*"* local class implementation
include ZCL_CDS_ALV_REPORT_GENERATOR==ccimp.

class ZCL_CDS_ALV_REPORT_GENERATOR implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_CDS_ALV_REPORT_GENERATOR implementation
