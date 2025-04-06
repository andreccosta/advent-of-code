require 'day01/part1'
require 'day01/part2'

RSpec.describe DayOne do
  let(:input) { file_input }

  describe DayOne::PartOne do
    subject(:solve) { described_class.solve(input) }

    context "when two digits match" do
      let(:input) { "1122" }

      it "calculates sum" do
        expect(solve).to eq(3)
      end
    end

    context "when only last digit matches" do
      let(:input) { "91212129" }

      it "calculates sum" do
        expect(solve).to eq(9)
      end
    end

    context "when given input" do
      it "calculates sum" do
        expect(solve).to eq(1102)
      end
    end
  end

  describe DayOne::PartTwo do
    subject(:solve) { described_class.solve(input) }

    context "when all digits match" do
      let(:input) { "1212" }

      it "calculates sum" do
        expect(solve).to eq(6)
      end
    end

    context "when all digits match" do
      let(:input) { "123123" }

      it "calculates sum" do
        expect(solve).to eq(12)
      end
    end

    context "when given input" do
      it "calculates sum" do
        expect(solve).to eq(1076)
      end
    end
  end
end
