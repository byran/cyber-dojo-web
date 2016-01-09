#!/usr/bin/ruby

require 'shellwords'

class ForegroundProcess
  def execute(command)
    `#{command}`
  end
end

class CurlOneSelfProcess

  def initialize(arguments, disk, process = ForegroundProcess.new)
    @arguments = arguments
    @disk = disk
    @process = process
  end

  def output_usage
    puts [
      "\nUsage:",
      "#{__FILE__} started <avatar_path>",
      "#{__FILE__} tested <tested_json>",
    ].join("\n")
  end

  def run

    # Make sure there are at least the two command line parameters needed
    if !@arguments[1]
      output_usage
      exit 1
    end

    @disk[@arguments[1]].write(one_self_manifest_filename, "")

  end

  def one_self_manifest_filename
    '1self_manifest.json'
  end

end

if ($0 == __FILE__)
  CurlOneSelfProcess.new(ARGV).run
end
