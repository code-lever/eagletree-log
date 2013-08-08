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

      its(:milliseconds?) { should be_true }

      it 'should have a few select milliseconds' do
        subject.milliseconds[0].should eql(0)
        subject.milliseconds[125].should eql(31250)
        subject.milliseconds[250].should eql(62500)
        subject.milliseconds[2230].should eql(557500)
      end

      its(:latitudes?) { should be_true }

      it 'should have a few select latitudes' do
        subject.latitudes[0].should be_within(0.0001).of(49.0775)
        subject.latitudes[1242].should be_within(0.0001).of(49.0793)
        subject.latitudes[1666].should be_within(0.0001).of(49.0750)
        subject.latitudes[2077].should be_within(0.0001).of(49.0771)
      end

      its(:longitudes?) { should be_true }

      it 'should have a few select longitudes' do
        subject.longitudes[0].should be_within(0.0001).of(2.1545)
        subject.longitudes[1356].should be_within(0.0001).of(2.1530)
        subject.longitudes[1727].should be_within(0.0001).of(2.1560)
        subject.longitudes[2317].should be_within(0.0001).of(2.1519)
      end

      its(:gps_altitudes?) { should be_true }

      it 'should have a few select gps_altitudes' do
        subject.gps_altitudes[864].should be_within(0.1).of(75.0)
        subject.gps_altitudes[1566].should be_within(0.1).of(208.0)
        subject.gps_altitudes[1879].should be_within(0.1).of(99.0)
        subject.gps_altitudes[2317].should be_within(0.1).of(168.0)
      end

      its(:coords) { should be_true }

      it 'should have a few select coords' do
        subject.coords[0][0].should be_within(0.0001).of(2.1545)
        subject.coords[0][1].should be_within(0.0001).of(49.0775)
        subject.coords[0][2].should be_within(0.1).of(102.0)
        subject.coords[0][3].should be_within(0.1).of(0.0)
        subject.coords[500][0].should be_within(0.0001).of(2.1545)
        subject.coords[500][1].should be_within(0.0001).of(49.0775)
        subject.coords[500][2].should be_within(0.1).of(75.0)
        subject.coords[500][3].should be_within(0.1).of(175.7)
        subject.coords[1500][0].should be_within(0.0001).of(2.1531)
        subject.coords[1500][1].should be_within(0.0001).of(49.0780)
        subject.coords[1500][2].should be_within(0.1).of(121.0)
        subject.coords[1500][3].should be_within(0.1).of(35.1)
        subject.coords[2500][0].should be_within(0.0001).of(2.1542)
        subject.coords[2500][1].should be_within(0.0001).of(49.0778)
        subject.coords[2500][2].should be_within(0.1).of(89.0)
        subject.coords[2500][3].should be_within(0.1).of(8.6)
      end

      its(:gps_speeds?) { should be_true }

      it 'should have a few select speeds' do
        subject.gps_speeds[0].should be_within(0.1).of(0.0)
        subject.gps_speeds[864].should be_within(0.1).of(0.7)
        subject.gps_speeds[1566].should be_within(0.1).of(194.6)
        subject.gps_speeds[1879].should be_within(0.1).of(180.6)
        subject.gps_speeds[2317].should be_within(0.1).of(126.7)
      end

      its(:gps_courses?) { should be_true }

      it 'should have a few select courses' do
        subject.gps_courses[0].should be_within(0.1).of(0.0)
        subject.gps_courses[864].should be_within(0.1).of(291.6)
        subject.gps_courses[1566].should be_within(0.1).of(197.6)
        subject.gps_courses[1879].should be_within(0.1).of(189.1)
        subject.gps_courses[2317].should be_within(0.1).of(266.1)
      end

      its(:gps_satellites?) { should be_true }

      it 'should have a few select satellites' do
        subject.gps_satellites[0].should eql(0)
        subject.gps_satellites[864].should eql(8)
        subject.gps_satellites[1566].should eql(7)
        subject.gps_satellites[1879].should eql(7)
        subject.gps_satellites[2317].should eql(8)
      end

      its(:to_kml?) { should be_true }

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

      its(:milliseconds?) { should be_true }

      it 'should have a few select milliseconds' do
        subject.milliseconds[0].should eql(0)
        subject.milliseconds[125].should eql(12500)
        subject.milliseconds[250].should eql(25000)
        subject.milliseconds[2230].should eql(223000)
      end

      its(:latitudes?) { should be_false }

      its(:longitudes?) { should be_false }

      its(:gps_altitudes?) { should be_false }

      its(:gps_speeds?) { should be_false }

      its(:gps_courses?) { should be_false }

      its(:gps_satellites?) { should be_false }

      specify { expect { subject.to_kml }.to raise_error(RuntimeError) }

    end

    context 'session 2' do

      subject { @file.sessions[1] }

      it { should have(3699).rows }

      its(:duration) { should be_within(0.1).of(369.9) }

      its(:milliseconds?) { should be_true }

      it 'should have a few select milliseconds' do
        subject.milliseconds[0].should eql(355500)
        subject.milliseconds[125].should eql(368000)
        subject.milliseconds[250].should eql(380500)
        subject.milliseconds[2230].should eql(578500)
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

      its(:latitudes?) { should be_false }

      its(:longitudes?) { should be_false }

      its(:gps_altitudes?) { should be_false }

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

    its(:altitudes?) { should be_false }

    its(:airspeeds?) { should be_false }

    its(:servo_currents?) { should be_false }

    its(:throttles?) { should be_false }

    its(:pack_voltages?) { should be_true }

    it 'should have a few select pack voltages' do
      subject.pack_voltages[0].should be_within(0.1).of(46.5)
      subject.pack_voltages[100].should be_within(0.1).of(46.5)
      subject.pack_voltages[250].should be_within(0.1).of(42.8)
      subject.pack_voltages[500].should be_within(0.1).of(45.2)
    end

    its(:amps?) { should be_true }

    it 'should have a few select amps' do
      subject.amps[0].should be_within(0.01).of(0.18)
      subject.amps[100].should be_within(0.01).of(0.31)
      subject.amps[250].should be_within(0.01).of(19.40)
      subject.amps[500].should be_within(0.01).of(0.12)
    end

    its(:temps1?) { should be_false }

    its(:temps2?) { should be_false }

    its(:temps3?) { should be_false }

    its(:rpms?) { should be_true }

    its(:rpms2?) { should be_false }

    its(:latitudes?) { should be_false }

    its(:longitudes?) { should be_false }

    its(:gps_altitudes?) { should be_false }

  end

  context 'data file t600-2.fdr' do

    before(:all) { @file = t600_2_fdr }

    subject { @file.sessions[0] }

    it { should have(865).rows }

    its(:duration) { should be_within(0.1).of(86.5) }

    its(:altitudes?) { should be_false }

    its(:airspeeds?) { should be_false }

    its(:servo_currents?) { should be_false }

    its(:throttles?) { should be_false }

    its(:pack_voltages?) { should be_true }

    it 'should have a few select pack voltages' do
      subject.pack_voltages[0].should be_within(0.1).of(46.6)
      subject.pack_voltages[100].should be_within(0.1).of(46.6)
      subject.pack_voltages[250].should be_within(0.1).of(46.6)
      subject.pack_voltages[500].should be_within(0.1).of(42.3)
    end

    its(:amps?) { should be_true }

    it 'should have a few select amps' do
      subject.amps[0].should be_within(0.01).of(0.18)
      subject.amps[100].should be_within(0.01).of(0.0)
      subject.amps[250].should be_within(0.01).of(0.0)
      subject.amps[500].should be_within(0.01).of(19.9)
    end

    its(:temps1?) { should be_false }

    its(:temps2?) { should be_false }

    its(:temps3?) { should be_false }

    its(:rpms?) { should be_true }

    its(:rpms2?) { should be_false }

    its(:latitudes?) { should be_false }

    its(:longitudes?) { should be_false }

    its(:gps_altitudes?) { should be_false }

    specify { expect { subject.to_kml }.to raise_error(RuntimeError) }

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
