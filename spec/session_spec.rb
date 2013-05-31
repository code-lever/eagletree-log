require 'spec_helper'

describe EagleTree::Log::Session do

  context 'data file trex_600.fdr' do

    subject { EagleTree::Log::File.new(data_file('trex_600.fdr')).sessions[0] }

    it { should have(692).rows }

    its(:duration) { should eql(69.2) }

    its(:altitudes?) { should be_false }

    its(:airspeeds?) { should be_false }

    its(:servo_currents?) { should be_false }

    its(:pack_voltages?) { should be_true }

    its(:throttles?) { should be_false }

  end

end
