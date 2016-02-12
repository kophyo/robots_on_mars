require 'spec_helper'

describe Robot do

  subject { Robot.new(grid)}

  let(:grid) do
    Grid.new(5, 5)
  end

  describe '#obey' do
    before do
      subject.set_position('3', '2', 'N')
    end
    context 'rotating' do
      it 'with L' do
        subject.obey('L')
        expect(subject.current_direction).to eq('W')
      end

      it 'with R' do
        subject.obey('R')
        expect(subject.current_direction).to eq('E')
      end

      it 'with LRRR' do
        subject.obey('LRRR')
        expect(subject.current_direction).to eq('S')
      end
    end

    context 'moving' do
      context 'within boundaries' do
        it 'moves forward with N' do
          subject.current_direction = 'N'
          subject.obey('F')
          expect(subject.current_direction).to eq('N')
          expect(subject.position.x_pos).to eq(3)
          expect(subject.position.y_pos).to eq(3)
        end

        it 'moves forward with E' do
          subject.current_direction = 'E'
          subject.obey('F')
          expect(subject.current_direction).to eq('E')
          expect(subject.position.x_pos).to eq(4)
          expect(subject.position.y_pos).to eq(2)
        end

        it 'moves forward with S' do
          subject.current_direction = 'S'
          subject.obey('F')
          expect(subject.current_direction).to eq('S')
          expect(subject.position.x_pos).to eq(3)
          expect(subject.position.y_pos).to eq(1)
        end

        it 'moves forward with W' do
          subject.current_direction = 'W'
          subject.obey('F')
          expect(subject.current_direction).to eq('W')
          expect(subject.position.x_pos).to eq(2)
          expect(subject.position.y_pos).to eq(2)
        end
      end

      context 'outside boundaries, with no lost_scent matching' do
        it 'moves forward with N' do
          subject.current_direction = 'N'
          subject.position = Position.new(3, 5)
          subject.obey('FRFF')
          expect(subject.current_direction).to eq('N')

          expect(subject.position.x_pos).to eq(3)
          expect(subject.position.y_pos).to eq(5)

          expect(grid.lost_positions.count).to eq(1)
          expect(grid.lost_positions.last.x_pos).to eq(3)
          expect(grid.lost_positions.last.y_pos).to eq(5)
        end
      end

      context 'outside boundaries, with no lost_scent matching' do
        it 'moves forward with N' do
          subject.current_direction = 'N'
          subject.position = Position.new(3, 5)
          grid.lost_positions << Position.new(3, 5)
          subject.obey('FRFF')
          expect(subject.current_direction).to eq('E')
          expect(subject.position.x_pos).to eq(5)
          expect(subject.position.y_pos).to eq(5)

        end
      end
    end
  end
end
