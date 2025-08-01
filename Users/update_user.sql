
CREATE OR REPLACE FUNCTION update_user(
  p_id INT,
  p_first_name TEXT DEFAULT NULL,
  p_last_name TEXT DEFAULT NULL,
  p_email TEXT DEFAULT NULL
)
RETURNS users
LANGUAGE plpgsql
AS $$
DECLARE
  updated_user users;
BEGIN
  -- Ensure the user exists
  IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_id AND deleted_at IS NULL) THEN
    RAISE EXCEPTION 'User not exist.';
  END IF;

  -- Perform partial update based on provided fields
  UPDATE users
  SET
    first_name = COALESCE(p_first_name, first_name),
    last_name = COALESCE(p_last_name, last_name),
    email = COALESCE(p_email, email),
    updated_at = CURRENT_DATE
  WHERE id = p_id
  RETURNING * INTO updated_user;

  RETURN updated_user;
END;
$$;

DROP FUNCTION update_user(int,text,text,text) 