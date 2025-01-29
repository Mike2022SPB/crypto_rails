require 'rails_helper'

RSpec.describe Currency, type: :model do
  describe '#actual_price' do
    let(:currency) { create(:currency) }
    context 'when there are multiple prices with different dates' do
      let!(:price_1) { create(:price, currency_id: currency.id, value: 1000.0, date: 1.day.ago) }
      let!(:price_2) { create(:price, currency_id: currency.id, value: 2000.0, date: 2.days.ago) }
      let!(:price_3) { create(:price, currency_id: currency.id, value: 1500.0, date: 3.days.ago) }
    end


    context 'when there is only one price' do
      let!(:price_1) { create(:price, currency_id: currency.id, value: 500.0, date: 1.day.ago) }
      
      it 'returns the value of one price' do
        expect(currency.actual_price).to eq(500.0)
      end
    end

    context 'when there is 2 prices' do
      let!(:price_1) { create(:price, currency_id: currency.id, value: 500.0, date: 2.day.ago) }
      let!(:price_2) { create(:price, currency_id: currency.id, value: 1500.0, date: 1.day.ago) }
      
      it 'returns the value of one price' do
        expect(currency.actual_price).to eq(1500.0)
      end
    end

    context 'when there is no prices' do
      it 'returns the value of one price' do
        expect(currency.actual_price).to be_nil
      end
    end
  end
end
