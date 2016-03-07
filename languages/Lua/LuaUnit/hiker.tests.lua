require('hiker')

EXPORT_ASSERT_TO_GLOBALS = true
require('luaunit')

TestHiker = {} --class
    function TestHiker:test_life_the_universe_and_everything()
        assertEquals( 42 , answer() )
    end

lu = LuaUnit.new()
os.exit( lu:runSuite() )
