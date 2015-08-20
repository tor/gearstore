-- Drop existing objects.
DROP TABLE IF EXISTS drupal7.gs3_legacy_users;
DROP TABLE IF EXISTS drupal7.gs3_deposits;
DROP TABLE IF EXISTS drupal7.gs3_gear_item_notes;
DROP TABLE IF EXISTS drupal7.gs3_gear_items;
DROP TABLE IF EXISTS drupal7.gs3_gear_item_types;
DROP TABLE IF EXISTS drupal7.gs3_rental_items;
DROP TABLE IF EXISTS drupal7.gs3_rentals;
DROP TABLE IF EXISTS drupal7.gs3_user_notes;
DROP TABLE IF EXISTS drupal7.gs3_schema_migrations;
DROP TABLE IF EXISTS drupal7.gs3_ledgers;
DROP TABLE IF EXISTS drupal7.gs3_reconcilled_users_log;
DROP TABLE IF EXISTS drupal7.gs3_legacy_old_to_new;

DROP VIEW IF EXISTS drupal7.gs3_users;
DROP VIEW IF EXISTS drupal7.gs3_roles;
DROP VIEW IF EXISTS drupal7.gs3_roles_users;

DROP PROCEDURE IF EXISTS drupal7.prc_gs3_rekey_user;
DROP PROCEDURE IF EXISTS drupal7.prc_gs3_rekey_all_users;

-- Dump the content of the g3_users view into an actual table for later
-- reconciliation.
CREATE TABLE drupal7.gs3_legacy_users AS 
SELECT * FROM anumc.gs3_users user
-- Only consider the users we need.
WHERE user.id > 0 
AND user.id IN (
	SELECT user_id FROM anumc.gs3_deposits
	UNION
	SELECT approver_id FROM anumc.gs3_gear_item_notes
	UNION
	SELECT user_id FROM anumc.gs3_ledgers
	UNION
	SELECT approver_id FROM anumc.gs3_ledgers
	UNION
	SELECT return_approver_id FROM anumc.gs3_rental_items
	UNION
	SELECT user_id FROM anumc.gs3_rentals
	UNION
	SELECT approver_id FROM anumc.gs3_rentals
	UNION
	SELECT user_id FROM anumc.gs3_user_notes
	UNION
	SELECT approver_id FROM anumc.gs3_user_notes
);

-- Add a boolean to mark legacy users as reconcilled.
ALTER TABLE drupal7.gs3_legacy_users ADD COLUMN
reconciled smallint DEFAULT 0;

-- Move existing data into the new database.
CREATE TABLE drupal7.gs3_deposits LIKE anumc.gs3_deposits;
INSERT INTO drupal7.gs3_deposits SELECT * FROM anumc.gs3_deposits;

CREATE TABLE drupal7.gs3_gear_item_notes LIKE anumc.gs3_gear_item_notes;
INSERT INTO drupal7.gs3_gear_item_notes SELECT * FROM anumc.gs3_gear_item_notes;

CREATE TABLE drupal7.gs3_gear_items LIKE anumc.gs3_gear_items;
INSERT INTO drupal7.gs3_gear_items SELECT * FROM anumc.gs3_gear_items;

CREATE TABLE drupal7.gs3_gear_item_types LIKE anumc.gs3_gear_item_types;
INSERT INTO drupal7.gs3_gear_item_types SELECT * FROM anumc.gs3_gear_item_types;

CREATE TABLE drupal7.gs3_rental_items LIKE anumc.gs3_rental_items;
INSERT INTO drupal7.gs3_rental_items SELECT * FROM anumc.gs3_rental_items;

CREATE TABLE drupal7.gs3_rentals LIKE anumc.gs3_rentals;
INSERT INTO drupal7.gs3_rentals SELECT * FROM anumc.gs3_rentals;

CREATE TABLE drupal7.gs3_user_notes LIKE anumc.gs3_user_notes;
INSERT INTO drupal7.gs3_user_notes SELECT * FROM anumc.gs3_user_notes;

CREATE TABLE drupal7.gs3_schema_migrations LIKE anumc.gs3_schema_migrations;
INSERT INTO drupal7.gs3_schema_migrations SELECT * FROM anumc.gs3_schema_migrations;

CREATE TABLE drupal7.gs3_ledgers LIKE anumc.gs3_ledgers;
INSERT INTO drupal7.gs3_ledgers SELECT * FROM anumc.gs3_ledgers;

-- List of users from Drupal 7 database
CREATE VIEW drupal7.gs3_users AS
SELECT 
	user.uid AS id,
	user.name AS username,
	user.pass AS pass,
	user.mail AS mail,
	CONCAT_WS(_UTF8' ',
			fn.field_account_first_name_value,
			ln.field_account_last_name_value) AS name,
	COALESCE(phone.field_account_home_phone_value,
			workPhone.field_account_work_phone_value,
			'') AS phone
FROM drupal7.users user
JOIN drupal7.field_data_field_account_first_name fn 
	ON fn.entity_id = user.uid
JOIN drupal7.field_data_field_account_last_name ln 
	ON ln.entity_id = user.uid
LEFT JOIN drupal7.field_data_field_account_home_phone phone 
	ON phone.entity_id = user.uid
LEFT JOIN drupal7.field_data_field_account_work_phone workPhone 
	ON workPhone.entity_id = user.uid
-- Select all the users from the Drupal 5 dump
UNION SELECT 
	legacy_user.id AS id,
	legacy_user.username AS username,
	legacy_user.pass AS pass,
	legacy_user.mail AS mail,
	-- Suffix for the old usernames
	CONCAT(legacy_user.name,
			_UTF8' (old website account)') AS name,
	legacy_user.phone AS phone
FROM drupal7.gs3_legacy_users legacy_user
-- We only want the users that haven't been reconcilled
WHERE legacy_user.reconciled = 0;
        
-- Roles and users.
CREATE VIEW drupal7.gs3_roles_users AS
    SELECT 
		uid AS user_id, 
        rid AS role_id
    FROM drupal7.users_roles;

CREATE VIEW drupal7.gs3_roles AS
    SELECT 
        rid AS id,
        name
    FROM drupal7.role;
    
-- Create a log of the reconcilled users.
CREATE TABLE drupal7.gs3_reconcilled_users_log (
	old_id INT,
    new_id INT,
    start_datetime DATETIME DEFAULT NOW()
);

-- Update all the old keys to avoid clashes.
UPDATE drupal7.gs3_legacy_users SET id = id + 500000;
UPDATE drupal7.gs3_deposits SET user_id = user_id + 500000;
UPDATE drupal7.gs3_gear_item_notes SET approver_id = approver_id + 500000;
UPDATE drupal7.gs3_ledgers SET user_id = user_id + 500000;
UPDATE drupal7.gs3_ledgers SET approver_id = approver_id + 500000;
UPDATE drupal7.gs3_rental_items SET return_approver_id = return_approver_id + 500000;
UPDATE drupal7.gs3_rentals SET user_id = user_id + 500000;
UPDATE drupal7.gs3_rentals SET approver_id = approver_id + 500000;
UPDATE drupal7.gs3_user_notes SET user_id = user_id + 500000;
UPDATE drupal7.gs3_user_notes SET approver_id = approver_id + 500000;

-- Dump the users into a temporary table before reconciling them.
DROP TABLE IF EXISTS drupal7.tmp_users;
CREATE TABLE drupal7.tmp_users AS
SELECT * FROM drupal7.gs3_users;

-- Create a table that reconcilled the users.
CREATE TABLE drupal7.gs3_legacy_old_to_new AS
SELECT DISTINCT
	  legacy.id AS old_id
    , users.id AS new_id
FROM drupal7.gs3_legacy_users legacy
JOIN drupal7.tmp_users users
	ON (users.mail = legacy.mail
    OR users.name = legacy.name)
    AND users.id < 500000
WHERE legacy.mail NOT LIKE '';

-- Cleanp.
DROP TABLE IF EXISTS drupal7.tmp_users;

-- Create a procedure that re-key one user.
DELIMITER //
CREATE PROCEDURE drupal7.prc_gs3_rekey_user ( 
	  IN old_id INT
	, IN new_id INT)
BEGIN
	UPDATE drupal7.gs3_deposits t
	SET t.user_id = new_id
    WHERE t.user_id = old_id;

	UPDATE drupal7.gs3_gear_item_notes t
	SET t.approver_id = new_id
    WHERE t.approver_id = old_id;

	UPDATE drupal7.gs3_ledgers t
	SET t.user_id = new_id
    WHERE t.user_id = old_id;

	UPDATE drupal7.gs3_ledgers t
	SET t.approver_id = new_id
    WHERE t.approver_id = old_id;

	UPDATE drupal7.gs3_rental_items t
	SET t.return_approver_id = new_id
    WHERE t.return_approver_id = old_id;

	UPDATE drupal7.gs3_rentals t
	SET t.user_id = new_id
    WHERE t.user_id = old_id;

	UPDATE drupal7.gs3_rentals t
	SET t.approver_id = new_id
    WHERE t.approver_id = old_id;

	UPDATE drupal7.gs3_user_notes t
	SET t.user_id = new_id
    WHERE t.user_id = old_id;

	UPDATE drupal7.gs3_user_notes t
	SET t.approver_id = new_id
    WHERE t.approver_id = old_id;
    
    -- Mark the user as reconciled.
    UPDATE drupal7.gs3_legacy_users t
    SET reconciled = 1
    WHERE t.id = old_id;
    
    -- Log the change of Id.
    INSERT INTO drupal7.gs3_reconcilled_users_log (old_id, new_id)
    VALUES (old_id, new_id);
    
END //

-- Update all the users.
CREATE PROCEDURE drupal7.prc_gs3_rekey_all_users()
BEGIN

  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE _old_id INT;
  DECLARE _new_id INT;
  
  DECLARE cur CURSOR FOR 
  SELECT old_id, new_id 
  FROM drupal7.gs3_legacy_old_to_new;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;
  
  OPEN cur;
  
  START TRANSACTION;
  updateLoop: LOOP
	FETCH cur INTO _old_id, _new_id;
    IF done THEN
      LEAVE updateLoop;
	END IF;
	CALL drupal7.prc_gs3_rekey_user(_old_id, _new_id);
  END LOOP updateLoop;
  COMMIT;

END //
DELIMITER ;

-- Re-key all users.
CALL drupal7.prc_gs3_rekey_all_users();

-- Select all the user that we failed to reconcile.
SELECT COUNT(*) FROM drupal7.gs3_legacy_users
WHERE reconciled = 0;


