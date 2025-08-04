CREATE OR REPLACE FUNCTION get_profile(p_user_id INT)
RETURNS caregiver_profiles
LANGUAGE plpgsql
AS $$
DECLARE
  result caregiver_profiles;
BEGIN
  SELECT *
  INTO result
  FROM caregiver_profiles
  WHERE user_id = p_user_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Caregiver profile not found for user_id: %', p_user_id;
  END IF;

  RETURN result;
END;
$$;

SELECT * FROM get_profile(16);