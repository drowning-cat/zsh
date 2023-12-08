() {
  typeset -gA keys

  local keyname= __= s= a= as= c= cs= ca= cas=
  local mod= keyseq= key=

  if (( "${+terminfo[smkx]}" && "${+terminfo[rmkx]}" )); then
	  autoload -Uz add-zle-hook-widget
	  function zle-application-mode-start { echoti smkx }
	  function zle-application-mode-stop { echoti rmkx }
	  add-zle-hook-widget -Uz zle-line-init zle-application-mode-start
	  add-zle-hook-widget -Uz zle-line-finish zle-application-mode-stop
  fi

  for keyname     __         s        a         as         c         cs        ca         cas  (
      'Up'        '[kcuu1]' '[kUP]'  '[kUP3]'  '[kUP4]'   '[kUP5]'  '[kUP6]'  '[kUP7]'   '^[[1;8A'
      'Down'      '[kcud1]' '[kDN]'  '[kDN3]'  '[kDN4]'   '[kDN5]'  '[kDN6]'  '[kDN7]'   '^[[1;8B'
      'Right'     '[kcuf1]' '[kRIT]' '[kRIT3]' '[kRIT4]'  '[kRIT5]' '[kRIT6]' '[kRIT7]'  '^[[1;8C'
      'Left'      '[kcub1]' '[kLFT]' '[kLFT3]' '[kLFT4]'  '[kLFT5]' '[kLFT6]' '[kLFT7]'  '^[[1;8D'
      'End'       '[kend]'  '[kEND]' '[kEND3]' '[kEND4]'  '[kEND5]' '[kEND6]' '[kEND7]'  '^[[1;8F'
      'Home'      '[khome]' '[kHOM]' '[kHOM3]' '[kHOM4]'  '[kHOM5]' '[kHOM6]' '[kHOM7]'  '^[[1;8H'
      'Insert'    '[kich1]' '[kIC]'  '[kIC3]'  '[kIC4]'   '[kIC5]'  '[kIC6]'  '[kIC7]'   '^[[2;8~'
      'Backspace' '[kbs]'   '^?'     '^[^?'    '^[\b'     '\b'      '\b'      '^[\b'     '^[\b'
      'Delete'    '[kdch1]' '[kDC]'  '[kDC3]'  '[kDC4]'   '[kDC5]'  '[kDC6]'  '[kDC7]'   '^[[3;8~'
      'PageUp'    '[kpp]'   '[kPRV]' '[kPRV3]' '[kPRV4]'  '[kPRV5]' '[kPRV6]' '[kPRV7]'  '^[[5;8~'
      'PageDown'  '[knp]'   '[kNXT]' '[kNXT3]' '[kNXT4]'  '[kNXT5]' '[kNXT6]' '[kNXT7]'  '^[[6;8~'
      'Tab'       '[ht]'    '[kcbt]' '^[\t'    ''          '\t'     ''        '^[\t'     ''
      'F1'        '[kf1]'   '[kf13]' '[kf49]'  '[kf61]'   '[kf25]'  '[kf37]'  '^[[1;7P'  '^[[1;8P'
      'F2'        '[kf2]'   '[kf14]' '[kf50]'  '[kf62]'   '[kf26]'  '[kf38]'  '^[[1;7Q'  '^[[1;8Q'
      'F3'        '[kf3]'   '[kf15]' '[kf51]'  '[kf63]'   '[kf27]'  '[kf39]'  '^[[1;7R'  '^[[1;8R'
      'F4'        '[kf4]'   '[kf16]' '[kf52]'  '^[[1;4S'  '[kf28]'  '[kf40]'  '^[[1;7S'  '^[[1;8S'
      'F5'        '[kf5]'   '[kf17]' '[kf53]'  '^[[15;4~' '[kf29]'  '[kf41]'  '^[[15;7~' '^[[15;8~'
      'F6'        '[kf6]'   '[kf18]' '[kf54]'  '^[[17;4~' '[kf30]'  '[kf42]'  '^[[17;7~' '^[[17;8~'
      'F7'        '[kf7]'   '[kf19]' '[kf55]'  '^[[18;4~' '[kf31]'  '[kf43]'  '^[[18;7~' '^[[18;8~'
      'F8'        '[kf8]'   '[kf20]' '[kf56]'  '^[[19;4~' '[kf32]'  '[kf44]'  '^[[19;7~' '^[[19;8~'
      'F9'        '[kf9]'   '[kf21]' '[kf57]'  '^[[20;4~' '[kf33]'  '[kf45]'  '^[[20;7~' '^[[20;8~'
      'F10'       '[kf10]'  '[kf22]' '[kf58]'  '^[[21;4~' '[kf34]'  '[kf46]'  '^[[21;7~' '^[[21;8~'
      'F11'       '[kf11]'  '[kf23]' '[kf59]'  '^[[23;4~' '[kf35]'  '[kf47]'  '^[[23;7~' '^[[23;8~'
      'F12'       '[kf12]'  '[kf24]' '[kf60]'  '^[[24;4~' '[kf36]'  '[kf48]'  '^[[24;7~' '^[[24;8~'
      'Minus'     '-'       '_'      '^[-'     '^[_'      '^_'      '^_'      '^[-'      '^[^_'
      'Equal'     '='       '+'      '^[='     '^[+'      ''        ''        '^[='      '^[+'
      'FSlash'    '/'       '?'      '^[/'     '^[?'      '^_'      ''        '^[^_'     '^[?'
  ) {
    for mod               keyseq (
        ''                "$__"
        'Shift-'          "$s"
        'Alt-'            "$a"
        'Alt-Shift-'      "$as"
        'Ctrl-'           "$c"
        'Ctrl-Shift-'     "$cs"
        'Ctrl-Alt-'       "$ca"
        'Ctrl-Alt-Shift-' "$cas"
    ) {
      if [[ "$keyseq" =~ '^\[.*\]$' ]]; then
        key="${keyseq[2,-2]}"
        keyseq="$terminfo[$key]"
      fi
      if [[ -z "$keyseq" ]]; then
        continue
      fi
      keys[$mod$keyname]="$keyseq"
    }
  }
}

