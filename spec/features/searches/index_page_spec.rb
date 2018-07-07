require 'rails_helper'

feature 'Index page', js: true do

  scenario 'Visit the search page' do
    visit searches_path

    sleep 2
    expect(page).to have_content 'Tweets Viewer'
  end

  scenario 'searches for keyword Futuruma from link' do
    VCR.use_cassette 'twitter/search/futuruma' do
      visit searches_path(q: 'futuruma')

      sleep 2
      expect(page).to have_content 'futuruma'
    end
  end

  scenario 'searches for keyword Futuruma by typing' do
    VCR.use_cassette 'twitter/search/futuruma' do
      visit searches_path

      within '.tweets_search_form' do
        find('input[name=q]').set("futuruma\n")
      end

      sleep 2
      expect(page).to have_content 'futuruma'
    end
  end

  scenario 'searches for keyword gibberish by typing' do
    VCR.use_cassette 'twitter/search/gibberish' do
      visit searches_path

      within '.tweets_search_form' do
        find('input[name=q]').set("futurumafuturuma\n")
      end

      sleep 2
      expect(page).to have_content 'Your search didn\'t return any result.'
      expect(page).to_not have_content 'futurumafuturuma'
    end
  end

  scenario 'searches for keyword gibberish from link' do
    VCR.use_cassette 'twitter/search/gibberish' do
      visit searches_path

      within '.tweets_search_form' do
        find('input[name=q]').set("futurumafuturuma\n")
      end

      sleep 2
      expect(page).to have_content 'Your search didn\'t return any result.'
      expect(page).to_not have_content 'futurumafuturuma'
    end
  end

end
