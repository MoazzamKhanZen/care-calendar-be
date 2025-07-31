CREATE OR REPLACE FUNCTION create_profile(
  p_user_id int,  -- assuming your user_id is a UUID or TEXT
  p_profile_image TEXT,
  p_phone_number TEXT,
  p_phone_code TEXT,
  p_country_code TEXT,
  p_location TEXT,
  p_specializations TEXT[],
  p_year_of_experience TEXT,
  p_bio TEXT,
  p_license TEXT DEFAULT NULL
)
RETURNS caregiver_profiles
LANGUAGE plpgsql
AS $$
DECLARE
  new_profile caregiver_profiles;
BEGIN
  -- Check if the user already has a profile
  IF EXISTS (
    SELECT 1 FROM caregiver_profiles WHERE user_id = p_user_id
  ) THEN
    RAISE EXCEPTION 'Caregiver Profile has already been created';
  END IF;

  -- Insert new profile
  INSERT INTO caregiver_profiles (
    user_id,
    profile_image,
    phone_number,
    phone_code,
    country_code,
    location,
    specializations,
    year_of_experience,
    bio,
    license
  )
  VALUES (
    p_user_id,
    p_profile_image,
    p_phone_number,
    p_phone_code,
    p_country_code,
    p_location,
    p_specializations,
    p_year_of_experience,
    p_bio,
    p_license
  )
  RETURNING * INTO new_profile;

  RETURN new_profile;
END;
$$;


SELECT * FROM create_profile(
  1,  -- user_id (TEXT or UUID)
  'https://example.com/image.jpg',
  '03123456789',
  '+92',
  'PK',
  'Karachi',
  ARRAY['Specialization1', 'Specialization2'],
  '5',
  'Bio about the caregiver',
  NULL 
);


DROP FUNCTION create_profile(text,text,text,user_role) 