fun! RfcReaderClear()
    lua require("plenary.reload").reload_module("rfc-reader")
endfun

fun! RfcReaderGet(...)
    call RfcReaderClear()

    " TODO: use telescope for quick autocomplete
    if a:0 > 0
        call luaeval('require("rfc-reader").get(_A)', a:1)
    else
        lua require("rfc-reader").get()
    end
endfun

com! RfcReaderGet call RfcReaderGet()

augroup RfcReader
    autocmd!
augroup END


