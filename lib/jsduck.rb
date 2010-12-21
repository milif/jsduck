# JsDuck is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# JsDuck is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with JsDuck.  If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2010 Rene Saarsoo.

$:.unshift File.dirname(__FILE__) # For running the actual JsDuck app

require 'jsduck/app'
require 'optparse'

if __FILE__ == $0 then
  app = JsDuck::App.new
  app.template_dir = File.dirname(File.dirname(__FILE__)) + "/template"

  opts = OptionParser.new do | opts |
    opts.banner = "Usage: ruby jsduck.rb [options] files..."

    opts.on('-o', '--output=PATH', "Directory to output all this amazing documentation.") do |path|
      app.output_dir = path
    end

    opts.on('-t', '--template=PATH', "Directory containing doc-browser UI template.") do |path|
      app.template_dir = path
    end

    opts.on('-v', '--verbose', "This will fill up your console.") do
      app.verbose = true
    end

    opts.on('-h', '--help', "Prints this help message") do
      puts opts
      exit
    end
  end

  app.input_files = opts.parse!(ARGV)

  if app.input_files.length == 0
    puts "You should specify some input files, otherwise there's nothing I can do :("
    exit(1)
  elsif !app.output_dir
    puts "You should also specify an output directory, where I could write all this amazing documentation."
    exit(1)
  elsif File.exists?(app.output_dir) && !File.directory?(app.output_dir)
    puts "Oh noes!  The output directory is not really a directory at all :("
    exit(1)
  elsif !File.exists?(File.dirname(app.output_dir))
    puts "Oh noes!  The parent directory for #{output_dir} doesn't exist."
    exit(1)
  end

  app.run()
end

