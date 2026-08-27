CREATE TABLE users (
    id PRIMARY KEY bigserial,
    username citetext NOT NULL UNIQUE,
    email citetext NOT NULL UNIQUE,
    password_hash text NOT NULL,
    full_name varchar(60) NOT NULL,
    bio varchar(150) NULL,
    avatar_url text NULL,
    website text NULL,
    is_private BOOLEAN NOT NULL DEFAULT false,
    is_verified BOOLEAN NOT NULL DEFAULT false,
    email_verified_at timestamptz NULL,
    deactivated_at timestamptz NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
)