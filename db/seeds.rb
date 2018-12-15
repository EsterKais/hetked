# frozen_string_literal: true

User.destroy_all

Profile.create(
  firstname: "Ester",
  lastname: "Kais",
  username: "deLuna",
  birthday: Date.today,
  user: User.create(email: "ester@kais.com")
)

Profile.create(
  firstname: "Cornelius",
  lastname: "Ehmke",
  username: "grunzihr",
  birthday: Date.new(1991, 12, 28),
  user: User.create(email: "corenlius@ehmke.com")
)
