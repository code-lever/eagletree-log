require 'spec_helper'

describe EagleTree::Log::File do

  context 'data file trex_600.fdr' do

    subject { EagleTree::Log::File.new(data_file('trex_600.fdr')) }

    it { should have(1).sessions }

    its(:hardware) { should eql('73') }

    its(:version) { should eql(6.93) }

  end

  it 'should raise on bad input' do
    expect { EagleTree::Log::File.new(__FILE__) }.to raise_error
  end

end
