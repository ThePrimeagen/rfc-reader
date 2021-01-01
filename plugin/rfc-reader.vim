fun! RfcReaderClear()
    lua require("plenary.reload").reload_module("rfc-reader")
endfun

fun! RfcReaderGet(rfcArg)
    call RfcReaderClear()

    " TODO: use telescope for quick autocomplete
    call luaeval('require("rfc-reader").get(_A)', a:rfcArg)
endfun

com! RfcReaderGet call RfcReaderGet()

augroup RfcReader
    autocmd!
augroup END


