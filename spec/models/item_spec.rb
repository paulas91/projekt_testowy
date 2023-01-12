describe Item, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
    it { is_expected.to have_db_column(:borrowed).of_type(:boolean) }
    it { is_expected.to have_db_column(:item_type).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_length_of(:name).is_at_most(25) }
    it { is_expected.to define_enum_for(:item_type).with_values(Item.item_types) }
  end
end
