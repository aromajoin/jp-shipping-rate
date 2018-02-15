RSpec.describe JPShippingRate do
  subject { JPShippingRate.instance }

  it 'has a version number' do
    expect(JPShippingRate::VERSION).not_to be nil
  end

  it 'Should have 8000(yen) EMS fee of 2000(g) parcel weight to US' do
    expect(subject.international(2000, 'US')).to eq(8_000)
  end

  it 'Should have 2570(yen) Yu-pack fee of 140(size) parcel to Tokyo' do
    expect(subject.domestic(140, 'tokyo')).to eq(2_570)
  end

  it 'Should have 4500(yen) EMS basic-fee of 2000(g) parcel weight to US' do
    expect(subject.international_rate(2000, 'nc_america')).to eq(4_500)
  end

  it 'Should have 1720(yen) Yu-pack basic fee of 140(size) parcel to Tokyo' do
    expect(subject.domestic_rate(140, 'kanto')).to eq(1_720)
  end
end
