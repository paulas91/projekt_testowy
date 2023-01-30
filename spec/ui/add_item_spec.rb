# frozen_string_literal: true

describe 'Add new item' do
  let(:user) { create(:user) }

  before do
    login_as user
    visit '/'
  end

  it 'adds a new item' do
    click_link 'New item'
    expect(page).to have_content('New item')

    fill_in 'item_name', with: 'Harry Potter i Komnata'
    select 'book', from: 'item[item_type]'
    click_button 'Create Item'
    expect(page).to have_content('Name')
    item_name = page.find('#item_name').value
    item_type = page.find('#item_item_type').value
    expect(item_name).to eq 'Harry Potter i Komnata'
    expect(item_type).to eq 'book'

    click_link 'Back to items'
    expect(page).to have_content('Harry Potter i Komnata')
    expect(page).to have_content('book')
  end
end
