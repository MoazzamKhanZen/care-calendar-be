create Table caregiver_profiles (
  id serial PRIMARY KEY,
  user_id int references users(id),
  profile_image text not null ,
  phone_number text not null,
  phone_code text not null,
  country_code text not null,
  location text not null,
  specializations text[] not null,
  year_of_experience  text not null,
  bio text not null,
  license text
)