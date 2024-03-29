# frozen_string_literal: true

describe 'example database' do
  it 'creates items' do
    Item.create(name: 'Book')
    expect(Item.count).to eq 1
  end

  it 'creates active items' do
    Item.create(name: 'wheel', active: true)
    expect(Item.count).to eq 1
    expect(item.name).to eq 'wheel'
    expect(item.active).to eq true
  end
end
