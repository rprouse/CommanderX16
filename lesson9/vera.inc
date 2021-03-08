.ifndef VERA_INC
VERA_INC  = 1

.ifndef __CX16__
__CX16__ = 1
.endif

; VERA
VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25
VERA_dc_video     = $9F29
VERA_dc_hscale    = $9F2A
VERA_dc_vscale    = $9F2B
VERA_L0_config    = $9F2D
VERA_L0_mapbase   = $9F2E
VERA_L0_tilebase  = $9F2F
VERA_L1_config    = $9F34
VERA_L1_mapbase   = $9F35
VERA_L1_tilebase  = $9F36

; VRAM Addresses
VRAM_layer1_map   = $00000
VRAM_layer0_map   = $04000
VRAM_lowerchars   = $0F000
VRAM_lower_rev    = VRAM_lowerchars + 128*8
VRAM_petscii      = $0F800
VRAM_palette      = $1FA00

; ROM Banks
ROM_BANK          = $9F60
BASIC_BANK        = 4
CHARSET_BANK      = 6

; Character Set ROM
LOWER_UPPER       = $C400

.endif
