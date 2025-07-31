CREATE OR REPLACE FUNCTION is_user_exist(p_email TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
  user_exists BOOLEAN;
BEGIN
  SELECT EXISTS (
    SELECT 1 FROM users
    WHERE email = p_email
      AND deleted_at IS NULL
  ) INTO user_exists;

  RETURN user_exists;
END;
$$;
