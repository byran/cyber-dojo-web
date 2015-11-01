#!/bin/bash ../test_wrapper.sh

require_relative './lib_test_base'
require 'shellwords'

class BackgroundProcessSpy
  def initialize
    @processes_started = []
  end

  attr_reader :processes_started

  def start(command)
    @processes_started << command
  end
end

class CurlOneSelfTests < LibTestBase

  def setup
    super
    set_git_class      'GitSpy'
    set_one_self_class 'OneSelfDummy'
    # important to use OneSelfDummy because
    # creating a new kata calls dojo.one_self.created
  end

  test '6B2BB0',
  'kata created' do
    processes = BackgroundProcessSpy.new
    one_self = CurlOneSelf.new(disk, processes)
    hash = {
      :now           => [2015, 9, 11, 18, 28, 14],
      :kata_id       => "F1A4B187E7",
      :exercise_name => "Fizz_Buzz",
      :language_name => "C (gcc)",
      :test_name     => "assert",
      :latitude      => '51.0190',
      :longtitude    => '3.1000'
    }

    one_self.created(hash)

    expected_command =
      "curl " +
      "--silent " +
      "--header content-type:application/json " +
      "--header authorization:ddbc8384eaf4b6f0e70d66b606ccbf7ad4bb22bfe113 " +
      "-X POST " +
      "-d '" +
      # switch to single quotes to save having to escape double quotes
      '{' +
      '"objectTags":["cyber-dojo"],' +
      '"actionTags":["create"],' +
      # Got a fail: dateTime came out as 2015-09-11T17
      # Not investigating further as Curl might not be kept anyway
      '"dateTime":"2015-09-11T18:28:14-00:00",' +
      '"location":{"lat":"51.0190","long":"3.1000"},' +
      '"properties":{' +
      '"dojo-id":"F1A4B187E7",' +
      '"exercise-name":"Fizz_Buzz",' +
      '"language-name":"C (gcc)",' +
      '"test-name":"assert"}}' +
      # back to double quotes
      "' " +
      "https://api.1self.co/v1/streams/GSYZNQSYANLMWEEH/events"

    assert_equal 1, processes.processes_started.length,
      'Incorrect number of processes started'

    actual_command = processes.processes_started[0]
    assert_equal expected_command, actual_command,
      'Incorrect curl process started'
  end

  # - - - - - - - - - - - - - - - - -

  test '2f1a25',
  'kata started' do
    processes = BackgroundProcessSpy.new
    one_self = CurlOneSelf.new(disk, processes)

    kata = make_kata
    lion = kata.start_avatar(['lion'])

    one_self.started(lion)

    command = "/var/www/cyber-dojo/lib/curl_one_self_process.rb started #{lion.path.shellescape}"
    expected_timedout_command = "timeout --signal=9 10s #{command}"

    assert_equal 1, processes.processes_started.length,
      'Incorrect number of processes started'

    actual_command = processes.processes_started[0]
    assert_equal expected_timedout_command, actual_command,
      'Incorrect background process started'
  end

  # - - - - - - - - - - - - - - - - -

  test 'ea26c8',
  'kata tested' do
    kata_tested_colour('red')
    kata_tested_colour('amber')
    kata_tested_colour('green')
    kata_tested_colour('timed_out')
  end

  def kata_tested_colour(colour)
    processes = BackgroundProcessSpy.new
    one_self = CurlOneSelf.new(disk, processes)

    kata = make_kata
    lion = kata.start_avatar(['lion'])

    hash = {
      :tag => 1,
      :colour => 'colour',
      :now => Time.now,
      :added_line_count => 2,
      :deleted_line_count => 6,
      :seconds_since_last_test => 45
    }
    one_self.tested(lion,hash)

    command = "/var/www/cyber-dojo/lib/curl_one_self_process.rb tested #{hash.to_json.shellescape} #{lion.path.shellescape}"
    expected_timedout_command = "timeout --signal=9 10s #{command}"

    assert_equal 1, processes.processes_started.length,
      'Incorrect number of processes started'

    actual_command = processes.processes_started[0]
    assert_equal expected_timedout_command, actual_command,
      'Incorrect background process started'

  end

end
