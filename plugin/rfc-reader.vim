fun! RfcReaderClear()
    lua require("plenary.reload").reload_module("rfc-reader")
endfun

fun! RfcReaderGet()
    call RfcReaderClear()

    " TODO: use telescope for quick autocomplete
    lua require("rfc-reader").get(ninit)
endfun

com! RfcReaderGet call RfcReaderGet()

augroup RfcReader
    autocmd!
augroup END


