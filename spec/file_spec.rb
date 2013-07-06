require 'spec_helper'

describe EagleTree::Log::File do

  describe '#new' do

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

    context 'data file multi-session-2.fdr' do

      subject { EagleTree::Log::File.new(data_file('multi-session-2.fdr')) }

      it { should have(3).sessions }

      its(:name) { should eql('Losi XXX4') }

      its(:hardware) { should eql('71') }

      its(:version) { should eql(6.02) }

    end

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

    it 'should raise for invalid or missing files' do
      files = invalid_data_files
      files.should have(17).files

      files.each do |f|
        expect { EagleTree::Log::File.new(f) }.to raise_error
      end
    end

  end

  describe '#eagle_tree?' do

    it 'should be false for invalid or missing files' do
      files = invalid_data_files
      files.should have(17).files

      files.each do |f|
        EagleTree::Log::File.eagle_tree?(f).should be_false
      end
    end

    it 'should be true for valid files' do
      files = data_files
      files.should have(9).files

      files.each do |f|
        EagleTree::Log::File.eagle_tree?(f).should be_true
      end
    end

  end

end
