require 'spec_helper'
require './player'
require './spec/custom/should_have_attr_accessor'

describe Player do
  it { should have_attr_accessor(:marker) }
  it { should have_attr_accessor(:wins) }
  it { should have_attr_accessor(:current_positions) }

  describe 'initialize' do
    it 'should set @current positions to an empty array' do
      neo = Player.new

      expect(neo.current_positions).to eq([])
    end

    it 'should set @wins to 0' do
      morpheus = Player.new

      expect(morpheus.wins).to eq(0)
    end
  end
end