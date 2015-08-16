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



