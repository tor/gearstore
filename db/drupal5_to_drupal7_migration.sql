-- Uncomment to delete all the gs3 items in the drupal7 database.
/*
DROP TABLE drupal7.gs3_legacy_users;
DROP TABLE drupal7.gs3_legacy_old_to_new;
DROP TABLE drupal7.gs3_deposits;
DROP TABLE drupal7.gs3_gear_item_notes;
DROP TABLE drupal7.gs3_gear_items;
DROP TABLE drupal7.gs3_gear_item_types;
DROP TABLE drupal7.gs3_rental_items;
DROP TABLE drupal7.gs3_rentals;
DROP TABLE drupal7.gs3_user_notes;
DROP TABLE drupal7.gs3_schema_migrations;
DROP TABLE drupal7.gs3_ledgers;
DROP VIEW drupal7.gs3_users;
DROP VIEW drupal7.gs3_roles;
DROP VIEW drupal7.gs3_roles_users;
/* */

-- Dump the content of the g3_users view into an actual table for later
-- reconciliation.
CREATE TABLE drupal7.gs3_legacy_users LIKE anumc.gs3_legacy_users;
INSERT INTO drupal7.gs3_legacy_users SELECT * FROM anumc.gs3_users;
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
        drupal7.users.uid AS id,
        drupal7.users.name AS username,
        drupal7.users.pass AS pass,
        drupal7.users.mail AS mail,
        CONCAT_WS(_UTF8' ',
                fn.field_account_first_name_value,
                ln.field_account_last_name_value) AS name,
        COALESCE(phone.field_account_home_phone_value,
                workPhone.field_account_work_phone_value,
                '') AS phone
    FROM drupal7.users
	JOIN drupal7.field_data_field_account_first_name fn 
		ON fn.entity_id = drupal7.users.uid
	JOIN drupal7.field_data_field_account_last_name ln 
		ON ln.entity_id = drupal7.users.uid
	LEFT JOIN drupal7.field_data_field_account_home_phone phone 
		ON phone.entity_id = drupal7.users.uid
	LEFT JOIN drupal7.field_data_field_account_work_phone workPhone 
		ON workPhone.entity_id = drupal7.users.uid
	-- Select all the users from the Drupal 5 dump.
    UNION SELECT 
        drupal7.gs3_legacy_users.id AS id,
        drupal7.gs3_legacy_users.username AS username,
        drupal7.gs3_legacy_users.pass AS pass,
        drupal7.gs3_legacy_users.mail AS mail,
        CONCAT(drupal7.gs3_legacy_users.name,
                _UTF8' (old)') AS name,
        drupal7.gs3_legacy_users.phone AS phone
    FROM drupal7.gs3_legacy_users;
        
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

-- Re-key the users.
START TRANSACTION;
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

-- Reconcile users.
CREATE TABLE drupal7.gs3_legacy_old_to_new
SELECT legacy.id as old_id, users.id as new_id
FROM drupal7.gs3_legacy_users legacy
JOIN drupal7.gs3_users users
	ON users.mail = legacy.mail
    OR users.name = legacy.name
WHERE legacy.mail NOT LIKE '';

UPDATE drupal7.gs3_deposits t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.user_id
SET t.user_id = o.new_id;

UPDATE drupal7.gs3_gear_item_notes t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.approver_id
SET t.approver_id = o.new_id;

UPDATE drupal7.gs3_ledgers t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.user_id
SET t.user_id = o.new_id;

UPDATE drupal7.gs3_ledgers t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.approver_id
SET t.approver_id = o.new_id;

UPDATE drupal7.gs3_rental_items t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.return_approver_id
SET t.return_approver_id = o.new_id;

UPDATE drupal7.gs3_rentals t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.user_id
SET t.user_id = o.new_id;

UPDATE drupal7.gs3_rentals t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.approver_id
SET t.approver_id = o.new_id;

UPDATE drupal7.gs3_user_notes t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.user_id
SET t.user_id = o.new_id;

UPDATE drupal7.gs3_user_notes t
JOIN drupal7.gs3_legacy_old_to_new o
	ON o.old_id = t.approver_id
SET t.approver_id = o.new_id;

-- Commit all the changes if the script was successful.
COMMIT;


