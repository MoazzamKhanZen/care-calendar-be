CREATE OR REPLACE FUNCTION get_user(p_email TEXT)
RETURNS users
LANGUAGE plpgsql
AS $$
DECLARE
  new_user users;
BEGIN
  SELECT * INTO new_user
  FROM users
  WHERE email = p_email
    AND deleted_at IS NULL
  LIMIT 1;

  RETURN new_user;
END;
$$;
