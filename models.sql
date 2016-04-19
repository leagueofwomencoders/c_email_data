drop table if exists persons;
drop sequence if exists persons_id_seq;

CREATE TABLE persons (
    id SERIAL NOT NULL,
    name VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE SEQUENCE persons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE persons_id_seq OWNED BY persons.id;
ALTER TABLE ONLY persons ALTER COLUMN id SET DEFAULT nextval('persons_id_seq'::regclass);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop table if exists aliases;
drop sequence if exists aliases_id_seq;

CREATE TABLE aliases (
    id SERIAL NOT NULL,
    alias VARCHAR(100) DEFAULT NULL,
    person_id INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(person_id) REFERENCES persons (id),
    PRIMARY KEY (id)
);

CREATE SEQUENCE aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE aliases_id_seq OWNED BY aliases.id;
ALTER TABLE ONLY aliases ALTER COLUMN id SET DEFAULT nextval('aliases_id_seq'::regclass);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop table if exists emails;
drop sequence if exists emails_id_seq;

CREATE TABLE emails (
    id SERIAL NOT NULL,
    doc_number VARCHAR(100) DEFAULT NULL,
    metadata_subject VARCHAR(400) DEFAULT NULL,
    metadata_to VARCHAR(100) DEFAULT NULL,
    metadata_from VARCHAR(100) DEFAULT NULL,
    sender_person_id INTEGER NOT NULL DEFAULT 0,
    metadata_date_sent TIMESTAMP DEFAULT NULL, -- Notice no time zone
    metadata_date_released TIMESTAMP DEFAULT NULL, -- Notice no time zone
    metadata_pdf_link VARCHAR(200) DEFAULT NULL,
    metadata_case_number VARCHAR(100) DEFAULT NULL,
    metadata_document_class VARCHAR(100) DEFAULT NULL,
    extracted_subject VARCHAR(400) DEFAULT NULL,
    extracted_to VARCHAR(100) DEFAULT NULL,
    extracted_from VARCHAR(100) DEFAULT NULL, -- ';' delimiter
    extracted_cc VARCHAR(100) DEFAULT NULL, -- ';' delimiter
    extracted_date_sent TIMESTAMP DEFAULT NULL, -- Notice no time zone
    extracted_case_number VARCHAR(100) DEFAULT NULL,
    extracted_doc_number VARCHAR(100) DEFAULT NULL,
    extracted_date_released TIMESTAMP DEFAULT NULL, -- Notice no time zone
    in_full BOOLEAN NOT NULL DEFAULT true, -- false = in part
    extracted_body_text TEXT DEFAULT NULL,
    raw_text TEXT DEFAULT NULL,
    FOREIGN KEY(sender_person_id) REFERENCES persons (id),
    PRIMARY KEY (id)
);


CREATE SEQUENCE emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE emails_id_seq OWNED BY emails.id;
ALTER TABLE ONLY emails ALTER COLUMN id SET DEFAULT nextval('emails_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop table if exists email_receivers;
drop sequence if exists email_receivers_id_seq;

CREATE TABLE email_receivers (
    id SERIAL NOT NULL,
    email_id INTEGER NOT NULL DEFAULT 0,
    person_id INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(email_id) REFERENCES emails (id),
    FOREIGN KEY(person_id) REFERENCES persons (id),
    PRIMARY KEY (id)
);

CREATE SEQUENCE email_receivers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE email_receivers_id_seq OWNED BY email_receivers.id;
ALTER TABLE ONLY email_receivers ALTER COLUMN id SET DEFAULT nextval('email_receivers_id_seq'::regclass);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
