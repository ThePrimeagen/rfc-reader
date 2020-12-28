local curl = require("plenary.curl");
local M = {};

-- TODO: Free rfc_reader_cache
rfc_reader_cache = rfc_reader_cache or {};

function parseResponse(body)
    local lines = {}
    for s in body:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end

    return lines
end

function createBuffer(lines)
    local bufh = vim.fn.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_option(bufh, "filetype", "rfc")

    vim.api.nvim_buf_set_lines(bufh, 0, #lines, false, lines)
    vim.api.nvim_buf_set_option(bufh, "modifiable", false)

    return bufh
end

M.get = function()

    local rfc = vim.fn.input("Rfc Number > ");
    local cache_money = rfc_reader_cache[rfc]
    print("Cache", rfc, cache_money)

    -- TODO: If they close the buffer, you are effd.  Gotta clear the cache
    if cache_money then
        vim.api.nvim_win_set_buf(0, cache_money.bufh)
    else
        local out = curl.request({
            url = "cht.sh/rfc/" .. rfc
        })

        local lines = parseResponse(out.body)
        local bufh = createBuffer(lines)

        rfc_reader_cache[rfc] = {
            contents = lines,
            bufh = bufh,
        }

        vim.api.nvim_win_set_buf(0, bufh)
    end
end

return M;
