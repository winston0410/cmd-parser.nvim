local number_range = "^(%d+)"
local mark_range = "^('%l)"
local forward_search_range = "^(/.*/)"
local backward_search_range = "^(?.*?)"
local special_range = "^([%%%.$])"

local command_pattern = "^(%l+)"
local range_patterns = {
    special_range, number_range, mark_range, forward_search_range,
    backward_search_range
}
local range_patterns_type = {
	"special", "number", "mark", "forward_search", "backward_search"
}

local function get_range(index, cmd)
    local range, type
    for i=1, #range_patterns do
        local _, end_index, result = string.find(cmd, range_patterns[i], index)
        if end_index then
            index = end_index
            range = result
			type = range_patterns_type[i]
            break
        end
    end
	if type == "special" then
		type = range
	end
    return range, type, index + 1
end

local function update_increment(operator, increment, acc_text, acc_num)
    local inc_str = acc_text .. operator .. increment
    if increment == "" then increment = 1 end
    return inc_str, acc_num + tonumber(operator .. increment)
end

local function get_increment(index, cmd)
    local pattern, inc_text, total, done = "([+-])(%d*)", "", 0, false
    while not done do
        local _, end_index, operator, increment =
            string.find(cmd, pattern, index)
        if not end_index then
            done = true
            break
        end
        inc_text, total = update_increment(operator, increment, inc_text, total)
        index = end_index + 1
    end

    return inc_text, total, index
end

local function parse_cmd(cmd)
    local result, next_index, _ = {}, 1, nil
    local start_range_text, end_range_text
    result.start_range, result.start_range_type, next_index = get_range(1, cmd)

    local comma_index = string.find(cmd, '[;,]', next_index)
    if comma_index then
        if not result.start_range then
            result.start_range = "."
            result.start_range_type = "."
        end
        start_range_text = string.sub(cmd, 1, comma_index)
    else
        start_range_text = cmd
    end
    result.start_increment, result.start_increment_number, next_index =
        get_increment(next_index, start_range_text)
    if comma_index then
        -- To offset the comma_index
        next_index = next_index + 1
        result.end_range, result.end_range_type, next_index = get_range(next_index, cmd)
        result.end_increment, result.end_increment_number, next_index =
            get_increment(next_index, cmd)
    end

    _, _, result.command = string.find(cmd, command_pattern, next_index)

    return result
end

local function setup() end

return {setup = setup, parse_cmd = parse_cmd}
