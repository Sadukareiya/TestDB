--<ScriptOptions statementTerminator=";"/>

CREATE TABLE proxies_priv (
	Host CHAR(60) NOT NULL,
	User CHAR(80) NOT NULL,
	Proxied_host CHAR(60) NOT NULL,
	Proxied_user CHAR(80) NOT NULL,
	With_grant BIT DEFAULT 0 NOT NULL,
	Grantor CHAR(141) NOT NULL,
	Timestamp TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	PRIMARY KEY (Host,User,Proxied_host,Proxied_user)
) ENGINE=Aria;

CREATE TABLE help_relation (
	help_topic_id INTEGER UNSIGNED NOT NULL,
	help_keyword_id INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY (help_keyword_id,help_topic_id)
) ENGINE=Aria;

CREATE TABLE procs_priv (
	Host CHAR(60) NOT NULL,
	Db CHAR(64) NOT NULL,
	User CHAR(80) NOT NULL,
	Routine_name CHAR(64) NOT NULL,
	Routine_type ENUM NOT NULL,
	Grantor CHAR(141) NOT NULL,
	Proc_priv null NOT NULL,
	Timestamp TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	PRIMARY KEY (Host,Db,User,Routine_name,Routine_type)
) ENGINE=Aria;

CREATE TABLE index_stats (
	db_name VARCHAR(64) NOT NULL,
	table_name VARCHAR(64) NOT NULL,
	index_name VARCHAR(64) NOT NULL,
	prefix_arity INTEGER UNSIGNED NOT NULL,
	avg_frequency DECIMAL(10 , 4),
	PRIMARY KEY (db_name,table_name,index_name,prefix_arity)
) ENGINE=Aria;

CREATE TABLE column_stats (
	db_name VARCHAR(64) NOT NULL,
	table_name VARCHAR(64) NOT NULL,
	column_name VARCHAR(64) NOT NULL,
	min_value VARBINARY(255),
	max_value VARBINARY(255),
	nulls_ratio DECIMAL(10 , 4),
	avg_length DECIMAL(10 , 4),
	avg_frequency DECIMAL(10 , 4),
	hist_size TINYINT UNSIGNED,
	hist_type ENUM,
	histogram VARBINARY(255),
	PRIMARY KEY (db_name,table_name,column_name)
) ENGINE=Aria;

CREATE TABLE time_zone_transition_type (
	Time_zone_id INTEGER UNSIGNED NOT NULL,
	Transition_type_id INTEGER UNSIGNED NOT NULL,
	Offset INT DEFAULT 0 NOT NULL,
	Is_DST TINYINT UNSIGNED DEFAULT 0 NOT NULL,
	Abbreviation CHAR(8) NOT NULL,
	PRIMARY KEY (Time_zone_id,Transition_type_id)
) ENGINE=Aria;

CREATE TABLE roles_mapping (
	Host CHAR(60) NOT NULL,
	User CHAR(80) NOT NULL,
	Role CHAR(80) NOT NULL,
	Admin_option ENUM DEFAULT N NOT NULL
) ENGINE=Aria;

CREATE TABLE help_keyword (
	help_keyword_id INTEGER UNSIGNED NOT NULL,
	name CHAR(64) NOT NULL,
	PRIMARY KEY (help_keyword_id)
) ENGINE=Aria;

CREATE TABLE servers (
	Server_name CHAR(64) NOT NULL,
	Host CHAR(64) NOT NULL,
	Db CHAR(64) NOT NULL,
	Username CHAR(80) NOT NULL,
	Password CHAR(64) NOT NULL,
	Port INT DEFAULT 0 NOT NULL,
	Socket CHAR(64) NOT NULL,
	Wrapper CHAR(64) NOT NULL,
	Owner CHAR(64) NOT NULL,
	PRIMARY KEY (Server_name)
) ENGINE=Aria;

CREATE TABLE general_log (
	event_time TIMESTAMP DEFAULT 'current_timestamp(6)' NOT NULL,
	user_host MEDIUMTEXT NOT NULL,
	thread_id BIGINT UNSIGNED NOT NULL,
	server_id INTEGER UNSIGNED NOT NULL,
	command_type VARCHAR(64) NOT NULL,
	argument MEDIUMTEXT NOT NULL
) ENGINE=CSV;

CREATE TABLE db (
	Host CHAR(60) NOT NULL,
	Db CHAR(64) NOT NULL,
	User CHAR(80) NOT NULL,
	Select_priv ENUM DEFAULT N NOT NULL,
	Insert_priv ENUM DEFAULT N NOT NULL,
	Update_priv ENUM DEFAULT N NOT NULL,
	Delete_priv ENUM DEFAULT N NOT NULL,
	Create_priv ENUM DEFAULT N NOT NULL,
	Drop_priv ENUM DEFAULT N NOT NULL,
	Grant_priv ENUM DEFAULT N NOT NULL,
	References_priv ENUM DEFAULT N NOT NULL,
	Index_priv ENUM DEFAULT N NOT NULL,
	Alter_priv ENUM DEFAULT N NOT NULL,
	Create_tmp_table_priv ENUM DEFAULT N NOT NULL,
	Lock_tables_priv ENUM DEFAULT N NOT NULL,
	Create_view_priv ENUM DEFAULT N NOT NULL,
	Show_view_priv ENUM DEFAULT N NOT NULL,
	Create_routine_priv ENUM DEFAULT N NOT NULL,
	Alter_routine_priv ENUM DEFAULT N NOT NULL,
	Execute_priv ENUM DEFAULT N NOT NULL,
	Event_priv ENUM DEFAULT N NOT NULL,
	Trigger_priv ENUM DEFAULT N NOT NULL,
	Delete_history_priv ENUM DEFAULT N NOT NULL,
	PRIMARY KEY (Host,Db,User)
) ENGINE=Aria;

CREATE TABLE transaction_registry (
	transaction_id BIGINT UNSIGNED NOT NULL,
	commit_id BIGINT UNSIGNED NOT NULL,
	begin_timestamp TIMESTAMP DEFAULT '0000-00-00 00:00:00.000000' NOT NULL,
	commit_timestamp TIMESTAMP DEFAULT '0000-00-00 00:00:00.000000' NOT NULL,
	isolation_level ENUM NOT NULL,
	PRIMARY KEY (transaction_id)
) ENGINE=InnoDB;

CREATE TABLE time_zone_name (
	Name CHAR(64) NOT NULL,
	Time_zone_id INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY (Name)
) ENGINE=Aria;

CREATE TABLE help_category (
	help_category_id SMALLINT UNSIGNED NOT NULL,
	name CHAR(64) NOT NULL,
	parent_category_id SMALLINT UNSIGNED,
	url TEXT NOT NULL,
	PRIMARY KEY (help_category_id)
) ENGINE=Aria;

CREATE TABLE func (
	name CHAR(64) NOT NULL,
	ret BIT DEFAULT 0 NOT NULL,
	dl CHAR(128) NOT NULL,
	type ENUM NOT NULL,
	PRIMARY KEY (name)
) ENGINE=Aria;

CREATE TABLE innodb_table_stats (
	database_name VARCHAR(64) NOT NULL,
	table_name VARCHAR(199) NOT NULL,
	last_update TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	n_rows BIGINT UNSIGNED NOT NULL,
	clustered_index_size BIGINT UNSIGNED NOT NULL,
	sum_of_other_index_sizes BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (database_name,table_name)
) ENGINE=InnoDB;

CREATE TABLE time_zone_leap_second (
	Transition_time BIGINT NOT NULL,
	Correction INT NOT NULL,
	PRIMARY KEY (Transition_time)
) ENGINE=Aria;

CREATE TABLE time_zone (
	Time_zone_id INTEGER UNSIGNED NOT NULL,
	Use_leap_seconds ENUM DEFAULT N NOT NULL,
	PRIMARY KEY (Time_zone_id)
) ENGINE=Aria;

CREATE TABLE slow_log (
	start_time TIMESTAMP DEFAULT 'current_timestamp(6)' NOT NULL,
	user_host MEDIUMTEXT NOT NULL,
	query_time TIME NOT NULL,
	lock_time TIME NOT NULL,
	rows_sent INT NOT NULL,
	rows_examined INT NOT NULL,
	db VARCHAR(512) NOT NULL,
	last_insert_id INT NOT NULL,
	insert_id INT NOT NULL,
	server_id INTEGER UNSIGNED NOT NULL,
	sql_text MEDIUMTEXT NOT NULL,
	thread_id BIGINT UNSIGNED NOT NULL,
	rows_affected INT NOT NULL
) ENGINE=CSV;

CREATE TABLE time_zone_transition (
	Time_zone_id INTEGER UNSIGNED NOT NULL,
	Transition_time BIGINT NOT NULL,
	Transition_type_id INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY (Time_zone_id,Transition_time)
) ENGINE=Aria;

CREATE TABLE table_stats (
	db_name VARCHAR(64) NOT NULL,
	table_name VARCHAR(64) NOT NULL,
	cardinality BIGINT UNSIGNED,
	PRIMARY KEY (db_name,table_name)
) ENGINE=Aria;

CREATE TABLE proc (
	db CHAR(64) NOT NULL,
	name CHAR(64) NOT NULL,
	type ENUM NOT NULL,
	specific_name CHAR(64) NOT NULL,
	language ENUM DEFAULT SQL NOT NULL,
	sql_data_access ENUM DEFAULT CONTAINS_SQL NOT NULL,
	is_deterministic ENUM DEFAULT NO NOT NULL,
	security_type ENUM DEFAULT DEFINER NOT NULL,
	param_list BLOB NOT NULL,
	returns LONGBLOB NOT NULL,
	body LONGBLOB NOT NULL,
	definer CHAR(141) NOT NULL,
	created TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	modified TIMESTAMP DEFAULT '0000-00-00 00:00:00' NOT NULL,
	sql_mode null NOT NULL,
	comment TEXT NOT NULL,
	character_set_client CHAR(32),
	collation_connection CHAR(32),
	db_collation CHAR(32),
	body_utf8 LONGBLOB,
	aggregate ENUM DEFAULT NONE NOT NULL,
	PRIMARY KEY (db,name,type)
) ENGINE=Aria;

CREATE TABLE columns_priv (
	Host CHAR(60) NOT NULL,
	Db CHAR(64) NOT NULL,
	User CHAR(80) NOT NULL,
	Table_name CHAR(64) NOT NULL,
	Column_name CHAR(64) NOT NULL,
	Timestamp TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	Column_priv null NOT NULL,
	PRIMARY KEY (Host,Db,User,Table_name,Column_name)
) ENGINE=Aria;

CREATE TABLE user (
	Host CHAR(60) NOT NULL,
	User CHAR(80) NOT NULL,
	Password LONGTEXT,
	Select_priv VARCHAR(1),
	Insert_priv VARCHAR(1),
	Update_priv VARCHAR(1),
	Delete_priv VARCHAR(1),
	Create_priv VARCHAR(1),
	Drop_priv VARCHAR(1),
	Reload_priv VARCHAR(1),
	Shutdown_priv VARCHAR(1),
	Process_priv VARCHAR(1),
	File_priv VARCHAR(1),
	Grant_priv VARCHAR(1),
	References_priv VARCHAR(1),
	Index_priv VARCHAR(1),
	Alter_priv VARCHAR(1),
	Show_db_priv VARCHAR(1),
	Super_priv VARCHAR(1),
	Create_tmp_table_priv VARCHAR(1),
	Lock_tables_priv VARCHAR(1),
	Execute_priv VARCHAR(1),
	Repl_slave_priv VARCHAR(1),
	Repl_client_priv VARCHAR(1),
	Create_view_priv VARCHAR(1),
	Show_view_priv VARCHAR(1),
	Create_routine_priv VARCHAR(1),
	Alter_routine_priv VARCHAR(1),
	Create_user_priv VARCHAR(1),
	Event_priv VARCHAR(1),
	Trigger_priv VARCHAR(1),
	Create_tablespace_priv VARCHAR(1),
	Delete_history_priv VARCHAR(1),
	ssl_type VARCHAR(9),
	ssl_cipher LONGTEXT NOT NULL,
	x509_issuer LONGTEXT NOT NULL,
	x509_subject LONGTEXT NOT NULL,
	max_questions BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	max_updates BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	max_connections BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	max_user_connections BIGINT DEFAULT 0 NOT NULL,
	plugin LONGTEXT NOT NULL,
	authentication_string LONGTEXT NOT NULL,
	password_expired VARCHAR(1) NOT NULL,
	is_role VARCHAR(1),
	default_role LONGTEXT NOT NULL,
	max_statement_time DECIMAL(10 , 6) DEFAULT 0.000000 NOT NULL
);

CREATE TABLE tables_priv (
	Host CHAR(60) NOT NULL,
	Db CHAR(64) NOT NULL,
	User CHAR(80) NOT NULL,
	Table_name CHAR(64) NOT NULL,
	Grantor CHAR(141) NOT NULL,
	Timestamp TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	Table_priv null NOT NULL,
	Column_priv null NOT NULL,
	PRIMARY KEY (Host,Db,User,Table_name)
) ENGINE=Aria;

CREATE TABLE plugin (
	name VARCHAR(64) NOT NULL,
	dl VARCHAR(128) NOT NULL,
	PRIMARY KEY (name)
) ENGINE=Aria;

CREATE TABLE gtid_slave_pos (
	domain_id INTEGER UNSIGNED NOT NULL,
	sub_id BIGINT UNSIGNED NOT NULL,
	server_id INTEGER UNSIGNED NOT NULL,
	seq_no BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (domain_id,sub_id)
) ENGINE=InnoDB;

CREATE TABLE help_topic (
	help_topic_id INTEGER UNSIGNED NOT NULL,
	name CHAR(64) NOT NULL,
	help_category_id SMALLINT UNSIGNED NOT NULL,
	description TEXT NOT NULL,
	example TEXT NOT NULL,
	url TEXT NOT NULL,
	PRIMARY KEY (help_topic_id)
) ENGINE=Aria;

CREATE TABLE global_priv (
	Host CHAR(60) NOT NULL,
	User CHAR(80) NOT NULL,
	Priv LONGTEXT DEFAULT '{}' NOT NULL,
	PRIMARY KEY (Host,User)
) ENGINE=Aria;

CREATE TABLE innodb_index_stats (
	database_name VARCHAR(64) NOT NULL,
	table_name VARCHAR(199) NOT NULL,
	index_name VARCHAR(64) NOT NULL,
	last_update TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	stat_name VARCHAR(64) NOT NULL,
	stat_value BIGINT UNSIGNED NOT NULL,
	sample_size BIGINT UNSIGNED,
	stat_description VARCHAR(1024) NOT NULL,
	PRIMARY KEY (database_name,table_name,index_name,stat_name)
) ENGINE=InnoDB;

CREATE TABLE event (
	db CHAR(64) NOT NULL,
	name CHAR(64) NOT NULL,
	body LONGBLOB NOT NULL,
	definer CHAR(141) NOT NULL,
	execute_at DATETIME,
	interval_value INT,
	interval_field ENUM,
	created TIMESTAMP DEFAULT 'current_timestamp()' NOT NULL,
	modified TIMESTAMP DEFAULT '0000-00-00 00:00:00' NOT NULL,
	last_executed DATETIME,
	starts DATETIME,
	ends DATETIME,
	status ENUM DEFAULT ENABLED NOT NULL,
	on_completion ENUM DEFAULT DROP NOT NULL,
	sql_mode null NOT NULL,
	comment CHAR(64) NOT NULL,
	originator INTEGER UNSIGNED NOT NULL,
	time_zone CHAR(64) DEFAULT SYSTEM NOT NULL,
	character_set_client CHAR(32),
	collation_connection CHAR(32),
	db_collation CHAR(32),
	body_utf8 LONGBLOB,
	PRIMARY KEY (db,name)
) ENGINE=Aria;

CREATE INDEX begin_timestamp ON transaction_registry (begin_timestamp ASC);

CREATE INDEX User ON db (User ASC);

CREATE INDEX Grantor ON procs_priv (Grantor ASC);

CREATE UNIQUE INDEX name ON help_topic (name ASC);

CREATE INDEX commit_timestamp ON transaction_registry (transaction_id ASC);

CREATE UNIQUE INDEX name ON help_keyword (name ASC);

CREATE INDEX Grantor ON tables_priv (Grantor ASC);

CREATE INDEX commit_timestamp ON transaction_registry (commit_timestamp ASC);

CREATE UNIQUE INDEX Host ON roles_mapping (Role ASC);

CREATE INDEX Grantor ON proxies_priv (Grantor ASC);

CREATE UNIQUE INDEX Host ON roles_mapping (User ASC);

CREATE UNIQUE INDEX name ON help_category (name ASC);

CREATE UNIQUE INDEX Host ON roles_mapping (Host ASC);

CREATE UNIQUE INDEX commit_id ON transaction_registry (commit_id ASC);

