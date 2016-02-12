require 'spec_helper'

describe Grid do

  subject { Grid.new(3, 5) }

  describe '#moveable?' do
    [
      {x_pos: 0, y_pos: 0, moveable: true},
      {x_pos: 3, y_pos: 5, moveable: true},
      {x_pos: -1, y_pos: 3, moveable: false},
      {x_pos: 1, y_pos: 6, moveable: false},
      {x_pos: -1, y_pos: 6, moveable: false}
    ].each do |hash|
      it "checks if position #{hash} is in boundaries" do
        new_position = double(x_pos: hash[:x_pos], y_pos: hash[:y_pos])
        expect(subject.moveable?(new_position)).to eq(hash[:moveable])
      end
    end
  end

  describe '#lost_scent?' do
    context 'with matching lost scent' do
      it 'returns true' do
        subject.lost_positions << double(x_pos: 2, y_pos: 2)
        position = double(x_pos: 2, y_pos: 2)
        expect(subject.lost_scent?(position)).to eq(true)
      end
    end

    context 'with no matching lost scent' do
      it 'returns false' do
        subject.lost_positions << double(x_pos: 2, y_pos: 1)
        position = double(x_pos: 2, y_pos: 2)
        expect(subject.lost_scent?(position)).to eq(false)
      end
    end
  end
end
