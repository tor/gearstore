-- List of users from Drupal 7 database
DROP VIEW IF EXISTS drupal7.gs3_users;
CREATE VIEW drupal7.gs3_users AS
SELECT
  user.uid AS id,
  user.name AS username,
  user.pass AS pass,
  user.mail AS mail,
  CONCAT_WS(_UTF8' ',
    fn.field_account_first_name_value,
    ln.field_account_last_name_value) AS name,
  COALESCE(
    mobilePhone.field_mobile_phone_value,
    phone.field_account_home_phone_value,
    workPhone.field_account_work_phone_value,
    '') AS phone,
  (
    SELECT GROUP_CONCAT(membership_year.field_membership_year_value SEPARATOR ', ')
    FROM drupal7.field_data_field_membership_year membership_year
    WHERE membership_year.entity_id = user.uid
    ) AS membership_years
FROM drupal7.users user
JOIN drupal7.field_data_field_account_first_name fn
  ON fn.entity_id = user.uid
JOIN drupal7.field_data_field_account_last_name ln
  ON ln.entity_id = user.uid
LEFT JOIN drupal7.field_data_field_account_home_phone phone
  ON phone.entity_id = user.uid
LEFT JOIN drupal7.field_data_field_account_work_phone workPhone
  ON workPhone.entity_id = user.uid
LEFT JOIN drupal7.field_data_field_mobile_phone mobilePhone
  ON mobilePhone.entity_id = user.uid
-- Select all the users from the Drupal 5 dump
UNION SELECT
  legacy_user.id AS id,
  legacy_user.username AS username,
  legacy_user.pass AS pass,
  legacy_user.mail AS mail,
  -- Suffix for the old usernames
  CONCAT(legacy_user.name,
      _UTF8' (old website account)') AS name,
  legacy_user.phone AS phone,
    null as membership_years
FROM drupal7.gs3_legacy_users legacy_user
-- We only want the users that haven't been reconcilled
WHERE legacy_user.reconciled = 0;

-- Roles and users.
DROP VIEW IF EXISTS drupal7.gs3_roles_users;
CREATE VIEW drupal7.gs3_roles_users AS
    SELECT
    uid AS user_id,
        rid AS role_id
    FROM drupal7.users_roles;

DROP VIEW IF EXISTS drupal7.gs3_roles;
CREATE VIEW drupal7.gs3_roles AS
    SELECT
        rid AS id,
        name
    FROM drupal7.role;
