def full_name(first_name, last_name)
  "#{first_name} #{last_name}"
end



describe 'test method' do
  it "returns full name based on params" do
    expect(full_name("Paulina", "Skopp")).to eq "Paulina Skopp"
  end
end
