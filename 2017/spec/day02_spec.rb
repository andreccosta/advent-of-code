require 'day02/part1'
require 'day02/part2'

RSpec.describe DayTwo do
  let(:input) { file_input }

  describe DayTwo::PartOne do
    subject(:solve) { described_class.solve(input) }

    it "calculates the checksum" do
      expect(solve).to eq(53978)
    end

    context "when given example" do
      let(:input) { file_example }

      it "calculates checksum" do
        expect(solve).to eq(18)
      end
    end
  end

  describe DayTwo::PartTwo do
    subject(:solve) { described_class.solve(input) }

    it "calculates the checksum" do
      expect(solve).to eq(314)
    end

    context "when given example" do
      let(:input) { file_example }

      it "calculates checksum" do
        expect(solve).to eq(9)
      end
    end
  end
end
