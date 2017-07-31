require_relative 'app_controller_test_base'

class ReverterControllerTest  < AppControllerTestBase

  test '81F276',
  'revert' do
    @id = create_kata
    @avatar = start
    kata_edit
    filename = 'hiker.c'
    change_file(filename, old_content='the_answer')
    run_tests # 1
    assert_equal old_content, @avatar.visible_files[filename]
    change_file(filename, new_content='something_different')
    run_tests # 2
    assert_equal new_content, @avatar.visible_files[filename]

    get 'reverter/revert', 'format' => 'json',
                           'id'     => @id,
                           'avatar' => @avatar.name,
                           'tag'    => 1
    assert_response :success

    visible_files = json['visibleFiles']
    refute_nil visible_files
    refute_nil visible_files['output']
    refute_nil visible_files[filename]
    assert_equal old_content, visible_files[filename]
  end

end
