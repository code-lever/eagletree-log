require 'spec_helper'

describe EagleTree::Log::File do

  context 'data file empty.fdr' do

    subject { EagleTree::Log::File.new(data_file('empty.fdr')) }

    it { should have(0).sessions }

    its(:name) { should eql('Skywalker') }

    its(:hardware) { should eql('74') }

    its(:version) { should eql(10.04) }

  end

  context 'data file funjet-gps.fdr' do

    subject { EagleTree::Log::File.new(data_file('funjet-gps.fdr')) }

    it { should have(1).sessions }

    its(:name) { should eql('FunJet') }

    its(:hardware) { should eql('73') }

    its(:version) { should eql(8.03) }

  end

  context 'data file multi-session-1.fdr' do

    subject { EagleTree::Log::File.new(data_file('multi-session-1.fdr')) }

    it { should have(3).sessions }

    its(:name) { should eql('Helis') }

    its(:hardware) { should eql('73') }

    its(:version) { should eql(6.93) }

  end

  #context 'data file multi-session-2.fdr' do
  #
  #  subject { EagleTree::Log::File.new(data_file('multi-session-2.fdr')) }
  #
  #  it { should have(3).sessions }
  #
  #  its(:name) { should eql('Losi XXX4') }
  #
  #  its(:hardware) { should eql('71') }
  #
  #  its(:version) { should eql(6.02) }
  #
  #end

  context 'data file t600-1.fdr' do

    subject { EagleTree::Log::File.new(data_file('t600-1.fdr')) }

    it { should have(1).sessions }

    its(:name) { should eql('T-Rex 600') }

    its(:hardware) { should eql('73') }

    its(:version) { should eql(6.93) }

  end

  context 'data file t600-2.fdr' do

    subject { EagleTree::Log::File.new(data_file('t600-2.fdr')) }

    it { should have(1).sessions }

    its(:name) { should eql('T-Rex 600') }

    its(:hardware) { should eql('73') }

    its(:version) { should eql(6.93) }

  end

  it 'should raise on bad input' do
    expect { EagleTree::Log::File.new(__FILE__) }.to raise_error
  end

end
