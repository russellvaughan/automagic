describe CsvImporter do
 let(:csv_importer) { described_class.new "api_key", "site_token" }

 describe "#convert_seperation" do
  it "converts semi-colon seperation to comma separation" do
   csv = [["Nome;email;OAB"]]
   expect(csv_importer.convert_seperation(csv)).to eq [["Nome","email","OAB"]]
 end
end

describe "#normalise" do
  it "converts non english characters" do
   csv =[["E-Posta", "Doðum Tarihi", "ip", "Ad Soyad", "Telefon Numarasý"]]
   csv_importer.normalise(csv)
   expect(csv_importer.normalise(csv)).to eq [["E-Posta", "Dodum Tarihi", "ip", "Ad Soyad", "Telefon Numarasy"]]
 end
end
describe "#read_csv" do

  context "with a comma seperated file" do
    let(:path) { "./spec/fixtures/comma.csv" }
    it "parses a csv file" do
      expected = [["id", "email", "dummy_email", "first name", "last name",
        "name", "full_name", "description", "company_position", "company_name",
        "created_at", "last.seen", "last.seen_unix", "last.location.country.code", "last.location.city",
        "totals.visits", "totals.pageviews", "totals.engaged_time", "first.referrer.href", "Plan", "NPS",
        "lead_score", "heard_about", "avatar", "phone", "company_position (rnd generator)", nil, nil, nil, nil]]
        expect(csv_importer.read_csv(path)).to eq expected
      end
    end

    context "with a semi-colon seperated file" do
      let(:path) { "./spec/fixtures/semi-colon.csv" }
      it "parses a csv file" do
        expected = [["Nome", "email", "OAB"]]
        expect(csv_importer.read_csv(path)).to eq expected
      end
    end

  end

end
