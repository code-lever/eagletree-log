require 'simplecov'
require 'simplecov-gem-adapter'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'gem' if ENV['COVERAGE']

require 'awesome_print'
require 'pathname'
require 'eagletree/log'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

# root from spec/data
def data_file(name)
  File.expand_path("#{File.dirname(__FILE__)}/data/#{name}")
end

def data_files
  dir = "#{File.dirname(__FILE__)}/data/#{dir}"
  Dir.glob("#{dir}/*").select { |e| File.file? e }
end

def invalid_data_files
  dir = "#{File.dirname(__FILE__)}/data/invalid"
  invalid = Dir.glob("#{dir}/**/*").select { |e| File.file? e }
  invalid << __FILE__
  invalid << 'NOFILE.TLM'
end

def empty_fdr; EagleTree::Log::File.new(data_file('empty.fdr')) end

def funjet_fdr; EagleTree::Log::File.new(data_file('funjet-gps.fdr')) end

def multi_1_fdr; EagleTree::Log::File.new(data_file('multi-session-1.fdr')) end

def multi_2_fdr; EagleTree::Log::File.new(data_file('multi-session-2.fdr')) end

def t600_1_fdr; EagleTree::Log::File.new(data_file('t600-1.fdr')) end

def t600_2_fdr; EagleTree::Log::File.new(data_file('t600-2.fdr')) end

def old_2_fdr; EagleTree::Log::File.new(data_file('old-2.fdr')) end

def old_3_fdr; EagleTree::Log::File.new(data_file('old-3.fdr')) end
