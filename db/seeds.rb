# frozen_string_literal: true

User.destroy_all

Profile.create(
  firstname: "Ester",
  lastname: "Kais",
  username: "deLuna",
  birthday: Date.today,
  user: User.create(email: "ester@kais.com")
)
