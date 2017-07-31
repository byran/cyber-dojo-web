
ENV['RAILS_ENV'] = 'test'

require_relative '../../test/all'
require_relative '../../config/environment'
require_relative 'params_maker'

class AppControllerTestBase < ActionDispatch::IntegrationTest

  include Externals
  include TestDomainHelpers
  include TestExternalHelpers
  include TestHexIdHelpers

  def setup
    super
    @dojo = Dojo.new(self)
    `rm -rf #{tmp_root}/caches`
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def create_kata(language_name = default_language, exercise_name = default_exercise)
    parts = language_name.split(',')
    params = {
         'major' => parts[0].strip,
         'minor' => parts[1].strip,
      'exercise' => exercise_name
    }
    get 'setup_default_start_point/save', params
    @id = json['id']
  end

  def start
    params = { 'format' => 'json', 'id' => @id }
    get 'enter/start', params
    assert_response :success
    avatar_name = json['avatar_name']
    assert_not_nil avatar_name
    @avatar = katas[@id].avatars[avatar_name]
    @params_maker = ParamsMaker.new(@avatar)
    @avatar
  end

  def start_full
    params = { 'format' => 'json', 'id' => @id }
    get 'enter/start', params
    assert_response :success
  end

  def resume
    params = { 'format' => 'json', 'id' => @id }
    get 'enter/resume', params
    assert_response :success
  end

  def kata_edit
    params = { 'id' => @id, 'avatar' => @avatar.name }
    get 'kata/edit', params
    assert_response :success
  end

  def content(filename)
    @params_maker.content(filename)
  end

  def change_file(filename, content)
    @params_maker.change_file(filename, content)
  end

  def delete_file(filename)
    @params_maker.delete_file(filename)
  end

  def new_file(filename, content)
    @params_maker.new_file(filename, content)
  end

  def run_tests
    params = {
      'format' => 'js',
      'id' => @id,
      'image_name' => katas[@id].image_name,
      'avatar' => @avatar.name,
      'runner_choice' => katas[@id].runner_choice
    }
    post 'kata/run_tests', params.merge(@params_maker.params)
    @params_maker = ParamsMaker.new(@avatar)
    assert_response :success
  end

  def hit_test
    run_tests
  end

  def json
    ActiveSupport::JSON.decode html
  end

  def html
    @response.body
  end

  private

  def default_language
    'C (gcc), assert'
  end

  def default_exercise
    'Yatzy'
  end

  def docker_pull_output
    [
      'Using default tag: latest',
      'latest: Pulling from cyberdojofoundation/python_unittest',
      'Digest: sha256:189ff7f8b3803815c5ad07c70830da0cbca0e62c01b0354cccc059dda8cf78bc',
      'Status: Image is up to date for cyberdojofoundation/python_unittest:latest'
    ].join("\n")
  end

  def exit_success
    0
  end

end

