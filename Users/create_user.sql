CREATE OR REPLACE FUNCTION create_user(
  p_first_name TEXT,
  p_last_name TEXT,
  p_email TEXT,
  p_role user_role DEFAULT 'User'
)
RETURNS users
LANGUAGE plpgsql
AS $$
DECLARE
  new_user users;
  existing_user users;
BEGIN
  SELECT * INTO existing_user FROM users WHERE email = p_email;
  
  IF FOUND THEN
    RAISE EXCEPTION 'User with this email already exists.';
  END IF;

  INSERT INTO users (first_name, last_name, email, role)
  VALUES (p_first_name, p_last_name, p_email, p_role)
  RETURNING * INTO new_user;

  RETURN new_user;
END;
$$;

SELECT * FROM create_user('Ali', 'Khan', 'ali.khan2@example.com', 'Caregiver');

DROP FUNCTION create_user(text,text,text,user_role) 