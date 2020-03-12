User.create!(
  [
    {
      email: 'aa@aa',
      name: 'aa',
      profile_image_id: nil,
      introduction: "aaaa",
      created_at: "2020-03-12 04:22:31",
      updated_at: "2020-03-12 04:22:32",
      postcode: "1810001",
      prefecture_code: "13",
      address_city: "三鷹市井の頭",
      address_street: "３−１６−４３",
      address_building: "WING井の頭203",
      address: Rails.root.join("app/assets/images/test1.png").open,
      latitude: 35.69357919999999,
      longitude: 139.5813218,
      password: "aaaaaa"
    },
    {
      email: 'bb@bb',
      name: 'bb',
      profile_image_id: nil,
      introduction: "bbbb",
      created_at: "2020-03-12 05:22:31",
      updated_at: "2020-03-12 05:22:32",
      postcode: "1810001",
      prefecture_code: "13",
      address_city: "三鷹市井の頭",
      address_street: "３−１６−４３",
      address_building: "WING井の頭203",
      address: nil,
      latitude: 35.69357919999999,
      longitude: 139.5813218,
      password: "bbbbbb"
    }
  ]
)