local lester = require 'lester'
local describe, it, expect = lester.describe, lester.it, lester.expect
local parse_cmd = require'init'.parse_cmd

-- customize lester configuration.
lester.show_traceback = false

describe('when parse_cmd is called', function()
    local result = parse_cmd("")
    it('should return a table',
       function() expect.equal(type(result), "table") end)
end)

describe('when it is called without range', function()
	local result = parse_cmd("d")
	it('should return nil start range',
	function() expect.equal(result.start_range, nil) end)
	it('should return nil start range type',
	function() expect.equal(result.start_range_type, nil) end)
end)

describe('when it is called with single number range', function()
    local result = parse_cmd("23d")
    it('should return the start range',
       function() expect.equal(result.start_range, "23") end)
    it('should return the start range type',
       function() expect.equal(result.start_range_type, "number") end)
    it('should return the command',
       function() expect.equal(result.command, "d") end)
end)
-- 
describe('when it is called with single number range', function()
    describe('when it has increment', function()
        local result = parse_cmd("23+5d")
        it('should return the command',
           function() expect.equal(result.command, "d") end)
        it('should return the start increment',
           function() expect.equal(result.start_increment, "+5") end)
        it('should return the start increment number',
           function() expect.equal(result.start_increment_number, 5) end)
    end)
end)

describe('when it is called with a complete number range', function()
    local result = parse_cmd("10,20d")
    it('should return the start range',
       function() expect.equal(result.start_range, "10") end)
    it('should return the end range',
       function() expect.equal(result.end_range, "20") end)
    it('should return the end range type',
       function() expect.equal(result.end_range_type, "number") end)
    it('should return the command',
       function() expect.equal(result.command, "d") end)
end)

describe('when it is called with a complete number range', function()
    local result = parse_cmd("10+3+++-,20d-8+")
    it('should return the start increment',
       function() expect.equal(result.start_increment, "+3+++-") end)
    it('should return the start increment number',
       function() expect.equal(result.start_increment_number, 5) end)
    it('should return the end increment',
       function() expect.equal(result.end_increment, "-8+") end)
    it('should return the end increment number',
       function() expect.equal(result.end_increment_number, -7) end)
end)

describe('when it is called with single mark range', function()
    local result = parse_cmd("'ad")
    it('should return the start range',
       function() expect.equal(result.start_range, "'a") end)
    it('should return the start range type',
       function() expect.equal(result.start_range_type, "mark") end)
    it('should return the command',
       function() expect.equal(result.command, "d") end)
end)

describe('when it is called with single mark range', function()
    describe('when it has increments', function()
        local result = parse_cmd("'a+2-5+3d")
        it('should return the start range increment',
           function() expect.equal(result.start_increment, "+2-5+3") end)
        it('should return the start range increment number',
           function() expect.equal(result.start_increment_number, 0) end)
    end)
end)

describe('when it is called with a complete mark range', function()
    local result = parse_cmd("'a,'bt")
    it('should return the start range',
       function() expect.equal(result.start_range, "'a") end)
    it('should return the end range',
       function() expect.equal(result.end_range, "'b") end)
    it('should return the end range type',
       function() expect.equal(result.end_range_type, "mark") end)
    it('should return the command',
       function() expect.equal(result.command, "t") end)
end)

describe('when it is called with a complete mark range', function()
    describe('when it has increment', function()
        local result = parse_cmd("'a+++-5,'b+20-t")
        it('should return the start range increment',
           function() expect.equal(result.start_increment, "+++-5") end)
        it('should return the start range increment number',
           function() expect.equal(result.start_increment_number, -2) end)
        it('should return the end range increment',
           function() expect.equal(result.end_increment, "+20-") end)
        it('should return the end range increment number',
           function() expect.equal(result.end_increment_number, 19) end)
    end)
end)

describe('when it is called with single forward search range', function()
    local result = parse_cmd("/hello/d")
    it('should return the start range',
       function() expect.equal(result.start_range, "/hello/") end)
    it('should return the start range type',
       function() expect.equal(result.start_range_type, "forward_search") end)
    it('should return the command',
       function() expect.equal(result.command, "d") end)
end)

describe('when it is called with single forward search range', function()
    describe('when it has increments', function()
        local result = parse_cmd("/hello/+10-2d")
        it('should return the start increment',
           function() expect.equal(result.start_increment, "+10-2") end)
        it('should return the start increment number',
           function() expect.equal(result.start_increment_number, 8) end)
    end)
end)

describe('when it is called with single backward search range', function()
    local result = parse_cmd("?hello?pu")
    it('should return the start range',
       function() expect.equal(result.start_range, "?hello?") end)
    it('should return the start range type',
       function() expect.equal(result.start_range_type, "backward_search") end)
    it('should return the command',
       function() expect.equal(result.command, "pu") end)
end)

describe('when it is called with single backward search range', function()
    describe('when it has increments', function()
        local result = parse_cmd("?hello?+10-3pu")
        it('should return the start increment',
           function() expect.equal(result.start_increment, "+10-3") end)
        it('should return the start increment number',
           function() expect.equal(result.start_increment_number, 7) end)
    end)
end)

describe('when it is called with single special range', function()
    local result = parse_cmd("%y")
    it('should return the start range',
       function() expect.equal(result.start_range, "%") end)
    it('should return the start range type',
       function() expect.equal(result.start_range_type, "%") end)
    it('should return the command',
       function() expect.equal(result.command, "y") end)
end)

describe('when it is called with single special range', function()
    describe('when it has increment', function()
        local result = parse_cmd("%y+20---")
        it('should return the start increment',
           function() expect.equal(result.start_increment, "+20---") end)
        it('should return the command',
           function() expect.equal(result.start_increment_number, 17) end)
    end)
end)

lester.report() -- Print overall statistic of the tests run.
lester.exit() -- Exit with success if all tests passed.
