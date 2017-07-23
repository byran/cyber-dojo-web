require_relative 'app_controller_test_base'

class SetupCustomStartPointControllerTest < AppControllerTestBase

  test 'EB77D9',
  'show shows all custom exercises' do
    # Assumes the exercises volume is default refactoring exercises
    assert_equal [
      'C++ Countdown, Practice Round',
      'C++ Countdown, Round 1',
      'C++ Countdown, Round 2',
      'C++ Countdown, Round 3',
      'C++ Countdown, Round 4',
      'C++ Countdown, Round 5',
      'C++ Countdown, Round 6',
      "Java Countdown, Practice Round",
      "Java Countdown, Round 1",
      "Java Countdown, Round 2",
      "Java Countdown, Round 3",
      "Java Countdown, Round 4",
      'Tennis refactoring, C# NUnit',
      'Tennis refactoring, C++ (g++) assert',
      'Tennis refactoring, Java JUnit',
      'Tennis refactoring, Python unitttest',
      'Tennis refactoring, Ruby Test::Unit',
      'Yahtzee refactoring, C# NUnit',
      'Yahtzee refactoring, C++ (g++) assert',
      'Yahtzee refactoring, Java JUnit',
      'Yahtzee refactoring, Python unitttest'
      ],
      custom_display_names

    do_get 'show'

    assert /data-major\=\"Tennis refactoring/.match(html)
    assert /data-major\=\"Yahtzee refactoring/.match(html)

    assert /data-minor\=\"C# NUnit/.match(html), html

    params = {
      'major' => 'Tennis refactoring',
      'minor' => 'C# NUnit'
    }
    do_get 'save', params
  end

  # - - - - - - - - - - - - - - - - - - - - - -

  private

  def do_get(route, params = {})
    controller = 'setup_custom_start_point'
    get "#{controller}/#{route}", params
    assert_response :success
  end

  # - - - - - - - - - - - - - - - - - - - - - -

  def custom_display_names
    custom.map(&:display_name).sort
  end

end
