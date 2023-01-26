require_relative '../lib/scraper_deputes'

describe "the get_depute_email method" do
  
  it "should return a string" do
    expect(get_depute_email("https://www.assemblee-nationale.fr/dyn/deputes/PA588884")).to be_an_instance_of(String)
  end

  it "should return the correct email" do
    expect(get_depute_email("https://www.assemblee-nationale.fr/dyn/deputes/PA588884")).to eq("clementine.autain@assemblee-nationale.fr")
  end

end

describe "the get_all_deputes_emails method" do

  it "returns an array of hashes" do
    expect(get_all_deputes_emails(PAGE_URL)).to be_an_instance_of(Array)
    expect(get_all_deputes_emails(PAGE_URL).all?(Hash)).to be true
  end

  it "scraps at least 550 URLs" do
    expect(get_all_deputes_emails(PAGE_URL).length).to be >= 550
  end

  it "scraps a few sample deputes" do
    expect(get_all_deputes_emails(PAGE_URL).include?({ "first_name" =>"Sandrine",
                                                 "last_name" =>"Rousseau",
                                                 "email" =>"sandrine.rousseau@assemblee-nationale.fr" })).to be true
    expect(get_all_deputes_emails(PAGE_URL).include?({ "first_name" =>"Marie-Agnes",
                                                 "last_name" =>"Poussier-Winsback",
                                                 "email" =>"marieagnes.poussier-winsback@assemblee-nationale.fr" })).to be true
    expect(get_all_deputes_emails(PAGE_URL).include?({ "first_name" =>"Nathalie",
                                                 "last_name" =>"Da Conceicao Carvalho",
                                                 "email" =>"nathalie.daconceicaocarvalho@assemblee-nationale.fr" })).to be true
  end
end

