require_relative '../../lib/disk_fake'

class RunnerStub

  def initialize(_parent)
    # This is @@disk and not @disk so that it behaves as
    # a real disk on tests that run across multiple threads
    # (as some app-controller tests do).
    @@disk ||= DiskFake.new(self)
  end

  # - - - - - - - - - - - - - - - - -

  def image_pulled?(_image_name, _kata_id); end
  def image_pull   (_image_name, _kata_id); end

  # - - - - - - - - - - - - - - - - -

  def kata_new(_image_name, _kata_id); end
  def kata_old(_image_name, _kata_id); end

  # - - - - - - - - - - - - - - - - -

  def avatar_new(_image_name, _kata_id, _avatar_name, _starting_files); end
  def avatar_old(_image_name, _kata_id, _avatar_name); end

  # - - - - - - - - - - - - - - - - -

  def stub_run_colour(colour)
    stub_run('', '', 0, colour)
  end

  def stub_run(stdout, stderr='', status=0, colour='red')
    dir.make
    dir.write(filename, [stdout,stderr,status,colour])
  end

  def run(_image_name, _kata_id, _name, _max_seconds, _delta, _files)
    if dir.exists?
      dir.read(filename)
    else
      [stdout='blah blah blah', stderr='', status=0, colour='red']
    end
  end

  def run_stateful(image_name, kata_id, avatar_name, max_seconds, delta, files)
    run(image_name, kata_id, avatar_name, max_seconds, delta, files)
  end

  def run_stateless(image_name, kata_id, avatar_name, max_seconds, delta, files)
    run(image_name, kata_id, avatar_name, max_seconds, delta, files)
  end

  private

  def filename
    'stub_output'
  end

  def dir
    disk[test_id]
  end

  def disk
    @@disk
  end

  def test_id
    ENV['CYBER_DOJO_TEST_ID']
  end

end
