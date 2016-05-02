require 'helper'

RSpec.describe YellowApi::Client::FindBusiness do
  let(:apikey) { ENV['YELLOW_API_KEY'] }

  before do
    @client = YellowApi::Client.new(apikey: apikey, uid: 'asdf')
    @client.sandbox_enabled = true
  end

  describe '.find_business' do
    subject { @client.find_business('barber', 'Canada') }

    it 'returns the correct number of businesses' do
      expect(subject.summary.listingsPerPage).to eq 15
      expect(subject.listings.count).to eq 15
    end

    it 'returns the correct format for businesses' do
      expect(subject.listings).to be_an Array
      expect(subject.listings).to all(be_a Hash)
      expect(subject.listings).to all have_key 'id'
      expect(subject.listings).to all have_key 'name'
      expect(subject.listings).to all have_key 'address'
    end

    it { is_expected.to be_a Hash }

    context 'With special characters' do
      subject { @client.find_business('h%C3%B4tels', 'Montreal') }

      it 'returns the correct number of businesses' do
        expect(subject.summary.listingsPerPage).to eq 15
        expect(subject.summary.page_count).to eq 70
        expect(subject.summary.total_listings).to eq 1039
        expect(subject.listings.count).to eq 15
      end

      it 'returns the correct format for businesses' do
        expect(subject.listings).to be_an Array
        expect(subject.listings).to all(be_a Hash)
        expect(subject.listings).to all have_key 'id'
        expect(subject.listings).to all have_key 'name'
        expect(subject.listings).to all have_key 'address'
      end

      it 'parses the special characters' do
        expect(subject.summary.what).to eq "hôtels"
      end
    end

    context 'with lat-lon where' do
      subject { @client.find_business('taco restaurant', 'cZ-73.61995,45.49981') }

      it 'returns the correct number of businesses' do
        expect(subject.summary.page_count).to eq 1
        expect(subject.summary.total_listings).to eq 12
        expect(subject.listings.count).to eq 12
      end

      it 'returns the correct format for businesses' do
        expect(subject.listings).to be_an Array
        expect(subject.listings).to all(be_a Hash)
        expect(subject.listings).to all have_key 'id'
        expect(subject.listings).to all have_key 'name'
        expect(subject.listings).to all have_key 'address'
      end
    end

    context 'with options' do
      subject { @client.find_business('hôtels', 'Montreal', pgLen: 3, pg: 2) }

      it 'returns the correct number of businesses' do
        expect(subject.summary.page_count).to eq 347
        expect(subject.summary.first_listing).to eq 4
        expect(subject.summary.listings_per_page).to eq 3
        expect(subject.listings.count).to eq 3
        expect(subject.summary.current_page).to eq 2
      end

      it 'gets the language' do
        en = @client.find_business('hôtels', 'Montreal', pgLen: 30, pg: 2, lang: 'en')
        fr = @client.find_business('hôtels', 'Montreal', pgLen: 30, pg: 2, lang: 'fr')
        expect(fr.summary).to eq en.summary
        expect(fr.listings).to_not match_array en.listings
      end
    end
  end
end
