require 'spec_helper'

describe EagleTree::Log::Session do

  context 'data file trex_600.fdr' do

    subject { EagleTree::Log::File.new(data_file('trex_600.fdr')).sessions[0] }

    it { should have(692).rows }

  end

end
