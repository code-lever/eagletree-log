require 'spec_helper'

describe EagleTree::Log::File do

  describe '#new' do

    context 'data file empty.fdr' do

      before(:all) { @file = empty_fdr }

      subject { @file }

      it { should have(0).sessions }

      its(:name) { should eql('Skywalker') }

      its(:hardware) { should eql('74') }

      its(:version) { should eql(10.04) }

    end

    context 'data file funjet-gps.fdr' do

      before(:all) { @file = funjet_fdr }

      subject { @file }

      it { should have(1).sessions }

      its(:duration) { should be_within(0.1).of(732.3) }

      its(:name) { should eql('FunJet') }

      its(:hardware) { should eql('73') }

      its(:version) { should eql(8.03) }

    end

    context 'data file multi-session-1.fdr' do

      before(:all) { @file = multi_1_fdr }

      subject { @file }

      it { should have(3).sessions }

      its(:duration) { should be_within(0.1).of(1149.3) }

      its(:name) { should eql('Helis') }

      its(:hardware) { should eql('73') }

      its(:version) { should eql(6.93) }

    end

    context 'data file multi-session-2.fdr' do

      before(:all) { @file = multi_2_fdr }

      subject { @file }

      it { should have(3).sessions }

      its(:name) { should eql('Losi XXX4') }

      its(:hardware) { should eql('71') }

      its(:version) { should eql(6.02) }

    end

    context 'data file old-1.fdr' do

      before(:all) { @file = old_1_fdr }

      subject { @file }

      it { should have(3).sessions }

      its(:name) { should eql('Model01') }

      its(:version) { should eql(0.0) }

      its(:duration) { should be_within(0.1).of(585.7) }

    end

    context 'data file old-2.fdr' do

      before(:all) { @file = old_2_fdr }

      subject { @file }

      it { should have(1).sessions }

      its(:name) { should eql('E-Observer') }

      its(:version) { should eql(5.7) }

      its(:duration) { should be_within(0.1).of(778.7) }

    end

    context 'data file old-3.fdr' do

      before(:all) { @file = old_3_fdr }

      subject { @file }

      it { should have(1).sessions }

      its(:name) { should eql('Prestige') }

      its(:version) { should eql(5.11) }

      its(:duration) { should be_within(0.1).of(2179.0) }

    end

    context 'data file t600-1.fdr' do

      before(:all) { @file = t600_1_fdr }

      subject { @file }

      it { should have(1).sessions }

      its(:name) { should eql('T-Rex 600') }

      its(:hardware) { should eql('73') }

      its(:version) { should eql(6.93) }

    end

    context 'data file t600-2.fdr' do

      before(:all) { @file = t600_2_fdr }

      subject { @file }

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
        expect(EagleTree::Log::File.eagle_tree?(f)).to be_false
      end
    end

    it 'should be true for valid files' do
      files = data_files
      files.should have(9).files

      files.each do |f|
        expect(EagleTree::Log::File.eagle_tree?(f)).to be_true
      end
    end

    it 'should return a file object' do
      expect(EagleTree::Log::File.eagle_tree?(data_files[0])).to be_a(EagleTree::Log::File)
    end

    it 'should return nil when invalid' do
      expect(EagleTree::Log::File.eagle_tree?(invalid_data_files[0])).to be_nil
    end

  end

  describe '#to_kml' do

    context 'with file with GPS data' do

      before(:all) { @file = funjet_fdr }

      subject { @file }

      its(:to_kml?) { should be_true }

      its(:to_kml) { should be_a(String) }

    end

    context 'with file without GPS data' do

      before(:all) { @file = multi_1_fdr }

      subject { @file }

      its(:to_kml?) { should be_false }

      it 'should raise w/o kml data' do
        expect { subject.to_kml }.to raise_error
      end

    end

  end

  describe '#to_kml_file' do

    context 'with file with GPS data' do

      before(:all) { @file = funjet_fdr }

      subject { @file }

      its(:to_kml_file) { should be_a(KMLFile) }

      it 'should take options for file and placemark' do
        kml = subject.to_kml_file({ :name => 'File Name' })
        expect(kml.objects[0].name).to eql('File Name')
      end

    end

    context 'with file without GPS data' do

      before(:all) { @file = multi_1_fdr }

      subject { @file }

      it 'should raise w/o kml data' do
        expect { subject.to_kml_file }.to raise_error
      end

    end

  end

end
