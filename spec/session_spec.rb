require 'spec_helper'

describe EagleTree::Log::Session do

  context 'data file funjet-gps.fdr' do

    before(:all) { @file = funjet_fdr }

    subject { @file }

    it { should have(1).sessions }

    context 'session 1' do

      subject { @file.sessions[0] }

      it { should have(2929).rows }

      its(:duration) { should be_within(0.1).of(732.3) }

      its(:milliseconds?) { should be true }

      it 'should have a few select milliseconds' do
        expect(subject.milliseconds[0]).to eql(0)
        expect(subject.milliseconds[125]).to eql(31250)
        expect(subject.milliseconds[250]).to eql(62500)
        expect(subject.milliseconds[2230]).to eql(557500)
      end

      its(:latitudes?) { should be true }

      it 'should have a few select latitudes' do
        expect(subject.latitudes[0]).to be_within(0.0001).of(49.0775)
        expect(subject.latitudes[1242]).to be_within(0.0001).of(49.0793)
        expect(subject.latitudes[1666]).to be_within(0.0001).of(49.0750)
        expect(subject.latitudes[2077]).to be_within(0.0001).of(49.0771)
      end

      its(:longitudes?) { should be true }

      it 'should have a few select longitudes' do
        expect(subject.longitudes[0]).to be_within(0.0001).of(2.1545)
        expect(subject.longitudes[1356]).to be_within(0.0001).of(2.1530)
        expect(subject.longitudes[1727]).to be_within(0.0001).of(2.1560)
        expect(subject.longitudes[2317]).to be_within(0.0001).of(2.1519)
      end

      its(:gps_altitudes?) { should be true }

      it 'should have a few select gps_altitudes' do
        expect(subject.gps_altitudes[864]).to be_within(0.1).of(75.0)
        expect(subject.gps_altitudes[1566]).to be_within(0.1).of(208.0)
        expect(subject.gps_altitudes[1879]).to be_within(0.1).of(99.0)
        expect(subject.gps_altitudes[2317]).to be_within(0.1).of(168.0)
      end

      its(:coords?) { should be true }

      it 'should have a few select coords' do
        expect(subject.coords[0][0]).to be_within(0.0001).of(2.1545)
        expect(subject.coords[0][1]).to be_within(0.0001).of(49.0775)
        expect(subject.coords[0][2]).to be_within(0.1).of(102.0)
        expect(subject.coords[0][3]).to be_within(0.1).of(0.0)
        expect(subject.coords[500][0]).to be_within(0.0001).of(2.1545)
        expect(subject.coords[500][1]).to be_within(0.0001).of(49.0775)
        expect(subject.coords[500][2]).to be_within(0.1).of(75.0)
        expect(subject.coords[500][3]).to be_within(0.1).of(175.7)
        expect(subject.coords[1500][0]).to be_within(0.0001).of(2.1531)
        expect(subject.coords[1500][1]).to be_within(0.0001).of(49.0780)
        expect(subject.coords[1500][2]).to be_within(0.1).of(121.0)
        expect(subject.coords[1500][3]).to be_within(0.1).of(35.1)
        expect(subject.coords[2500][0]).to be_within(0.0001).of(2.1542)
        expect(subject.coords[2500][1]).to be_within(0.0001).of(49.0778)
        expect(subject.coords[2500][2]).to be_within(0.1).of(89.0)
        expect(subject.coords[2500][3]).to be_within(0.1).of(8.6)
      end

      its(:gps_speeds?) { should be true }

      it 'should have a few select speeds' do
        expect(subject.gps_speeds[0]).to be_within(0.1).of(0.0)
        expect(subject.gps_speeds[864]).to be_within(0.1).of(0.7)
        expect(subject.gps_speeds[1566]).to be_within(0.1).of(194.6)
        expect(subject.gps_speeds[1879]).to be_within(0.1).of(180.6)
        expect(subject.gps_speeds[2317]).to be_within(0.1).of(126.7)
      end

      its(:gps_courses?) { should be true }

      it 'should have a few select courses' do
        expect(subject.gps_courses[0]).to be_within(0.1).of(0.0)
        expect(subject.gps_courses[864]).to be_within(0.1).of(291.6)
        expect(subject.gps_courses[1566]).to be_within(0.1).of(197.6)
        expect(subject.gps_courses[1879]).to be_within(0.1).of(189.1)
        expect(subject.gps_courses[2317]).to be_within(0.1).of(266.1)
      end

      its(:gps_satellites?) { should be true }

      it 'should have a few select satellites' do
        expect(subject.gps_satellites[0]).to eql(0)
        expect(subject.gps_satellites[864]).to eql(8)
        expect(subject.gps_satellites[1566]).to eql(7)
        expect(subject.gps_satellites[1879]).to eql(7)
        expect(subject.gps_satellites[2317]).to eql(8)
      end

      its(:to_kml?) { should be true }

      its(:to_kml) { should_not be_nil }

    end

  end

  context 'data file multi-session-1.fdr' do

    before(:all) { @file = multi_1_fdr }

    subject { @file }

    it { should have(3).sessions }

    context 'session 1' do

      subject { @file.sessions[0] }

      it { should have(3555).rows }

      its(:duration) { should be_within(0.1).of(355.5) }

      its(:milliseconds?) { should be true }

      it 'should have a few select milliseconds' do
        expect(subject.milliseconds[0]).to eql(0)
        expect(subject.milliseconds[125]).to eql(12500)
        expect(subject.milliseconds[250]).to eql(25000)
        expect(subject.milliseconds[2230]).to eql(223000)
      end

      its(:latitudes?) { should be false }

      its(:longitudes?) { should be false }

      its(:gps_altitudes?) { should be false }

      its(:gps_speeds?) { should be false }

      its(:gps_courses?) { should be false }

      its(:gps_satellites?) { should be false }

      specify { expect { subject.to_kml }.to raise_error(RuntimeError) }

    end

    context 'session 2' do

      subject { @file.sessions[1] }

      it { should have(3699).rows }

      its(:duration) { should be_within(0.1).of(369.9) }

      its(:milliseconds?) { should be true }

      it 'should have a few select milliseconds' do
        expect(subject.milliseconds[0]).to eql(355500)
        expect(subject.milliseconds[125]).to eql(368000)
        expect(subject.milliseconds[250]).to eql(380500)
        expect(subject.milliseconds[2230]).to eql(578500)
      end

    end

    context 'session 3' do

      subject { @file.sessions[2] }

      it { should have(4241).rows }

      its(:duration) { should be_within(0.1).of(424.0) }

    end

  end

  context 'data file multi-session-2.fdr' do

    before(:all) { @file = multi_2_fdr }

    subject { @file }

    it { should have(3).sessions }

    context 'session 1' do

      subject { @file.sessions[0] }

      it { should have(226).rows }

      its(:duration) { should be_within(0.1).of(22.6) }

      its(:latitudes?) { should be false }

      its(:longitudes?) { should be false }

      its(:gps_altitudes?) { should be false }

    end

    context 'session 2' do

      subject { @file.sessions[1] }

      it { should have(124).rows }

      its(:duration) { should be_within(0.1).of(12.4) }

    end

    context 'session 3' do

      subject { @file.sessions[2] }

      it { should have(6336).rows }

      its(:duration) { should be_within(0.1).of(633.5) }

    end

  end

  context 'data file t600-1.fdr' do

    before(:all) { @file = t600_1_fdr }

    subject { @file.sessions[0] }

    it { should have(692).rows }

    its(:duration) { should be_within(0.1).of(69.2) }

    its(:altitudes?) { should be false }

    its(:airspeeds?) { should be false }

    its(:servo_currents?) { should be false }

    its(:throttles?) { should be false }

    its(:pack_voltages?) { should be true }

    it 'should have a few select pack voltages' do
      expect(subject.pack_voltages[0]).to be_within(0.1).of(46.5)
      expect(subject.pack_voltages[100]).to be_within(0.1).of(46.5)
      expect(subject.pack_voltages[250]).to be_within(0.1).of(42.8)
      expect(subject.pack_voltages[500]).to be_within(0.1).of(45.2)
    end

    its(:amps?) { should be true }

    it 'should have a few select amps' do
      expect(subject.amps[0]).to be_within(0.01).of(0.18)
      expect(subject.amps[100]).to be_within(0.01).of(0.31)
      expect(subject.amps[250]).to be_within(0.01).of(19.40)
      expect(subject.amps[500]).to be_within(0.01).of(0.12)
    end

    its(:temps1?) { should be false }

    its(:temps2?) { should be false }

    its(:temps3?) { should be false }

    its(:rpms?) { should be true }

    its(:rpms2?) { should be false }

    its(:latitudes?) { should be false }

    its(:longitudes?) { should be false }

    its(:gps_altitudes?) { should be false }

  end

  context 'data file t600-2.fdr' do

    before(:all) { @file = t600_2_fdr }

    subject { @file.sessions[0] }

    it { should have(865).rows }

    its(:duration) { should be_within(0.1).of(86.5) }

    its(:altitudes?) { should be false }

    its(:airspeeds?) { should be false }

    its(:servo_currents?) { should be false }

    its(:throttles?) { should be false }

    its(:pack_voltages?) { should be true }

    it 'should have a few select pack voltages' do
      expect(subject.pack_voltages[0]).to be_within(0.1).of(46.6)
      expect(subject.pack_voltages[100]).to be_within(0.1).of(46.6)
      expect(subject.pack_voltages[250]).to be_within(0.1).of(46.6)
      expect(subject.pack_voltages[500]).to be_within(0.1).of(42.3)
    end

    its(:amps?) { should be true }

    it 'should have a few select amps' do
      expect(subject.amps[0]).to be_within(0.01).of(0.18)
      expect(subject.amps[100]).to be_within(0.01).of(0.0)
      expect(subject.amps[250]).to be_within(0.01).of(0.0)
      expect(subject.amps[500]).to be_within(0.01).of(19.9)
    end

    its(:temps1?) { should be false }

    its(:temps2?) { should be false }

    its(:temps3?) { should be false }

    its(:rpms?) { should be true }

    its(:rpms2?) { should be false }

    its(:latitudes?) { should be false }

    its(:longitudes?) { should be false }

    its(:gps_altitudes?) { should be false }

    specify { expect { subject.to_kml }.to raise_error(RuntimeError) }

  end

  context 'data file old-2.fdr' do

    before(:all) { @file = old_2_fdr }

    context 'session 0' do

      subject { @file.sessions[0] }

      its(:duration) { should be_within(0.1).of(778.7) }

      it { should have(7787).milliseconds }

      its(:altitudes?) { should be false }

      its(:airspeeds?) { should be false }

      its(:servo_currents?) { should be false }

      its(:throttles?) { should be false }

      its(:pack_voltages?) { should be true }

      its(:amps?) { should be true }

      its(:temps1?) { should be true }

      its(:temps2?) { should be true }

      its(:temps3?) { should be false }

      its(:rpms?) { should be false }

      its(:rpms2?) { should be false }

      its(:latitudes?) { should be false }

      its(:longitudes?) { should be false }

      its(:gps_altitudes?) { should be false }

    end

  end

  context 'data file old-3.fdr' do

    before(:all) { @file = old_3_fdr }

    context 'session 0' do

      subject { @file.sessions[0] }

      its(:duration) { should be_within(0.1).of(2179.0) }

      it { should have(8716).milliseconds }

      its(:altitudes?) { should be false }

      its(:airspeeds?) { should be false }

      its(:servo_currents?) { should be false }

      its(:throttles?) { should be false }

      its(:pack_voltages?) { should be true }

      its(:amps?) { should be true }

      its(:temps1?) { should be true }

      its(:temps2?) { should be true }

      its(:temps3?) { should be false }

      its(:rpms?) { should be false }

      its(:rpms2?) { should be false }

      its(:latitudes?) { should be false }

      its(:longitudes?) { should be false }

      its(:gps_altitudes?) { should be false }

    end

  end

  describe '#to_kml' do

    subject { file.sessions[0] }

    context 'with GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('funjet-gps.fdr')) }

      its(:to_kml) { should be_a(String) }

    end

    context 'without GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('old-2.fdr')) }

      it 'should raise w/o kml data' do
        expect { subject.to_kml }.to raise_error
      end

    end

  end

  describe '#to_kml_file' do

    subject { file.sessions[0] }

    context 'with GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('funjet-gps.fdr')) }

      its(:to_kml_file) { should be_a(KMLFile) }

      it 'should take options for file and placemark' do
        kml = subject.to_kml_file({ :name => 'File Name' }, { :name => 'Placemark Name' })
        kml.objects[0].name.should eql('File Name')
        kml.objects[0].features[0].name.should eql('Placemark Name')
      end

    end

    context 'without GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('old-2.fdr')) }

      it 'should raise w/o kml data' do
        expect { subject.to_kml_file }.to raise_error
      end

    end

  end

  describe '#to_kml_placemark' do

    subject { file.sessions[0] }

    context 'with GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('funjet-gps.fdr')) }

      its(:to_kml_placemark) { should be_a(KML::Placemark) }

    end

    context 'without GPS data' do

      let(:file) { EagleTree::Log::File.new(data_file('old-2.fdr')) }

      it 'should raise w/o kml data' do
        expect { subject.to_kml_placemark }.to raise_error
      end

    end

  end

end
