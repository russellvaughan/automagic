describe ColumnSeparatorFinder do
  describe ".find" do
    subject(:find) { described_class.find(path) }

    let(:path) { "./spec/fixtures/comma.csv" }

    context "when , delimiter" do
      it "returns separator" do
        expect(find).to eq(',')
      end
    end

    context "when ; delimiter" do
      let(:path) { "./spec/fixtures/semi-colon.csv" }

      it "returns separator" do
        expect(find).to eq(';')
      end
    end

    context "when | delimiter" do
      let(:path) { "./spec/fixtures/pipe.csv" }

      it "returns separator" do
        expect(find).to eq('|')
      end
    end

    context "when empty file" do
      it "raises error" do
        expect(File).to receive(:open) { [] }
        expect { find }.to raise_error(described_class::EmptyFile)
      end
    end

    context "when no column separator is found" do
      it "raises error" do
        expect(File).to receive(:open) { [''] }
        expect { find }.to raise_error(described_class::NoColumnSeparatorFound)
      end
    end
  end
end
