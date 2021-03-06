require_relative 'app_lib_test_base'

class FileDeltaMakerTest < AppLibTestBase

  def self.hex_prefix
    '89FA01'
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  def hex_setup
    set_differ_class('NotUsed')
    set_runner_class('NotUsed')
    set_storer_class('NotUsed')
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test '27F',
  'unchanged files seen as :unchanged' do
    @was = { 'wibble.h' => 3424234 }
    @now = { 'wibble.h' => 3424234 }
    make_delta
    assert_changed []
    assert_unchanged ['wibble.h']
    assert_deleted []
    assert_new []
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test '5A4',
  'changed files seen as :changed' do
    @was = { 'wibble.h' => 52674 }
    @now = { 'wibble.h' => 3424234 }
    make_delta
    assert_changed ['wibble.h']
    assert_unchanged []
    assert_deleted []
    assert_new []
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test 'B12',
  'deleted files seen as :deleted' do
    @was = { 'wibble.h' => 52674 }
    @now = {}
    make_delta
    assert_changed []
    assert_unchanged []
    assert_deleted ['wibble.h']
    assert_new []
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test '94B',
  'new files seen as :new' do
    @was = {}
    @now = { 'wibble.h' => 52674 }
    make_delta
    assert_changed []
    assert_unchanged []
    assert_deleted []
    assert_new ['wibble.h']
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test 'A92',
  'example with :unchanged, :changed, :deleted, and :new' do
    @was = { 'wibble.h' => 52674, 'wibble.c' => 3424234, 'fubar.h' => -234 }
    @now = { 'wibble.h' => 52674, 'wibble.c' => 46532, 'snafu.c' => -345345 }
    make_delta
    assert_changed ['wibble.c']
    assert_unchanged ['wibble.h']
    assert_deleted ['fubar.h']
    assert_new ['snafu.c']
  end

  private

  def make_delta
    @delta = FileDeltaMaker.make_delta(@was, @now)
  end

  def assert_changed(expected)
    assert_equal expected, @delta[:changed]
  end

  def assert_unchanged(expected)
    assert_equal expected, @delta[:unchanged]
  end

  def assert_deleted(expected)
    assert_equal expected, @delta[:deleted]
  end

  def assert_new(expected)
    assert_equal expected, @delta[:new]
  end

end
