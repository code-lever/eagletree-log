require 'spec_helper'

describe EagleTree::Log::Session do

  context 'data file t600-1.fdr' do

    subject { EagleTree::Log::File.new(data_file('t600-1.fdr')).sessions[0] }

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

  end

  context 'data file t600-2.fdr' do

    subject { EagleTree::Log::File.new(data_file('t600-2.fdr')).sessions[0] }

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

  end

end
