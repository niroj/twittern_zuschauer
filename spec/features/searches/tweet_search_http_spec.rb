feature 'Tweet search via http visit' do

  scenario 'Visit the search page' do
    visit searches_path

    expect(page).to have_content 'Tweets Viewer'
  end

  scenario 'searches for keyword Futuruma' do
    VCR.use_cassette 'twitter/search/futuruma' do
      visit searches_path(q: 'futuruma')

      expect(page).to have_content 'futuruma'
    end
  end

  scenario 'searches for keyword gibberish from link' do
    VCR.use_cassette 'twitter/search/gibberish' do
      visit searches_path(q: 'gibberishgibberish')

      expect(page).to have_content 'Your search didn\'t return any result.'
      expect(page).to_not have_content 'gibberishgibberish'
    end
  end

  scenario 'properly handles blank keyword' do
    visit searches_path(q: nil)

    expect(page).to have_content 'Tweets Viewer'
    expect(page).to_not have_content 'Your search didn\'t return any result.'
  end
end
