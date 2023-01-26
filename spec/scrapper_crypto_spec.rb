require_relative '../lib/scrapper_crypto'


describe "the fuse_attributes method" do
  it "returns an array of hashes" do
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page))).to be_an_instance_of(Array)
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page)).all?(Hash)).to be true
  end

  it "scraps at least 15 cryptos" do
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page)).length).to be > 15
  end

  it "scraps a few key cryptos" do
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page)).any? { |hash| hash.keys.include?('BTC') }).to be true
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page)).any? { |hash| hash.keys.include?('ETH') }).to be true
    expect(fuse_attributes(scrap_names(Page), scrap_values(Page)).any? { |hash| hash.keys.include?('USDC') }).to be true
  end
end


