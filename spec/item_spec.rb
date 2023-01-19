# frozen_string_literal: true

describe Item do
  it 'creates item with name' do
    described_class.create(name: 'book')
    expect(item.name).to eq 'book'
  end

  context 'when name not passed' do
    it 'does not create item' do
      described_class.create(name: '')
      expect(described_class.count).to eq 0
    end
  end

  context 'when lenght to short' do
    it 'does not create item' do
      described_class.create(name: 'as')
      expect(described_class.count).to eq 0
    end

    it 'is not valid' do
      described_class.new(name: 'as')
      expect(item.valid?).to eq false
    end
  end
end
