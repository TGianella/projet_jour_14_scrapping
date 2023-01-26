require_relative '../lib/scraper_townhall'

describe "the get_townhall_email method" do
  
  it "should return a string" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")).to be_an_instance_of(String)
  end

  it "should return the correct email" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")).to eq("mairie.avernes@orange.fr")
  end

end

describe "the get_townhall_urls method" do

  it "returns an array of hashes" do
    expect(get_townhall_urls(PAGE_URL)).to be_an_instance_of(Array)
    expect(get_townhall_urls(PAGE_URL).all?(Hash)).to be true
  end

  it "scraps at least 160 town URLs" do
    expect(get_townhall_urls(PAGE_URL).length).to be >= 160
  end

  it "scraps a few sample cities" do
    expect(get_townhall_urls(PAGE_URL).include?({ "PONTOISE" =>"https://www.annuaire-des-mairies.com/95/pontoise.html" })).to be true
    expect(get_townhall_urls(PAGE_URL).include?({ "MONTMORENCY" =>"https://www.annuaire-des-mairies.com/95/montmorency.html" })).to be true
    expect(get_townhall_urls(PAGE_URL).include?({ "L ISLE ADAM" =>"https://www.annuaire-des-mairies.com/95/l-isle-adam.html" })).to be true
  end
end

describe "the get_townhall_emails_from_URL_hash" do
  
  it "should return an array of hashes" do
    expect(get_townhall_emails_from_URL_hash([{"PONTOISE" =>
                                               "https://www.annuaire-des-mairies.com/95/pontoise.html"},
                                              {"GARGES LES GONESSE"=>
                                               "https://www.annuaire-des-mairies.com/95/garges-les-gonesse.html"}])).to be_an_instance_of(Array)
    expect(get_townhall_emails_from_URL_hash([{"PONTOISE" =>
                                               "https://www.annuaire-des-mairies.com/95/pontoise.html"},
                                              {"GARGES LES GONESSE"=>
                                               "https://www.annuaire-des-mairies.com/95/garges-les-gonesse.html"}]).all?(Hash)).to be true
  end



  it "should update each hash's value (URL) with the email adress" do
    expect(get_townhall_emails_from_URL_hash([{"PONTOISE" =>
                                               "https://www.annuaire-des-mairies.com/95/pontoise.html"}])).
                                                 to eq([{"PONTOISE" =>"mairie@ville-pontoise.fr"}])
    expect(get_townhall_emails_from_URL_hash([{"BEZONS" =>
                                               "https://www.annuaire-des-mairies.com/95/bezons.html"}])).
                                                 to eq([{"BEZONS" =>"courrier@mairie-bezons.fr"}])
  end
end

    
    
    

