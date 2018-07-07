feature 'Tweet search via ajax request', js: true do

  scenario 'searches for keyword Futuruma' do
    VCR.use_cassette 'twitter/search/futuruma' do
      visit searches_path
      find('input[name=q]').set("futuruma\n")

      expect(page).to have_content 'futuruma'
    end

  end

  scenario 'searches for keyword gibberish' do
    VCR.use_cassette 'twitter/search/gibberish' do
      visit searches_path
      find('input[name=q]').set("gibberishgibberish\n")

      expect(page).to have_content 'Your search didn\'t return any result.'
      expect(page).to_not have_content 'gibberishgibberish'
    end
  end

  scenario 'properly handles blank keyword' do
    visit searches_path
    find('input[name=q]').set("\n")

    expect(page).to have_content 'Tweets Viewer'
    expect(page).to have_content 'Your search didn\'t return any result.'
  end
end
