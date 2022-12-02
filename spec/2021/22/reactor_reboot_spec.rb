# typed: false
# frozen_string_literal: true

require_relative '../../../2021/22/reactor_reboot'

RSpec.describe ReactorReboot do
  describe 'on_count' do
    it 'counts switches in on state after processing input' do
      expect(described_class.new("#{__dir__}/input").run.on_count).to eq(647_062)
    end
  end
end
