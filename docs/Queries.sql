
CREATE EXTENSION IF NOT EXISTS citext;


-- ============================================================ roots =========

CREATE TABLE users (
    id                bigserial     PRIMARY KEY,
    username          citext        NOT NULL UNIQUE,
    email             citext        NOT NULL UNIQUE,
    password_hash     text          NOT NULL,
    full_name         varchar(60)   NOT NULL,
    bio               varchar(150)  NULL,
    avatar_url        text          NULL,
    website           text          NULL,
    is_private        boolean       NOT NULL DEFAULT false,
    is_verified       boolean       NOT NULL DEFAULT false,
    email_verified_at timestamptz   NULL,
    deactivated_at    timestamptz   NULL,
    created_at        timestamptz   NOT NULL DEFAULT now(),
    updated_at        timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT users_username_length CHECK (length(username) BETWEEN 3 AND 30),
    CONSTRAINT users_email_length    CHECK (length(email) <= 254)
);

CREATE TABLE locations (
    id         bigserial    PRIMARY KEY,
    name       varchar(255) NOT NULL,
    latitude   numeric(8,6) NOT NULL,
    longitude  numeric(9,6) NOT NULL,
    created_at timestamptz  NOT NULL DEFAULT now(),
    CONSTRAINT locations_latitude_range  CHECK (latitude  BETWEEN -90  AND 90),
    CONSTRAINT locations_longitude_range CHECK (longitude BETWEEN -180 AND 180)
);

CREATE INDEX locations_lat_lng_idx ON locations (latitude, longitude);

CREATE TABLE hashtags (
    id         bigserial   PRIMARY KEY,
    title      citext      NOT NULL UNIQUE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT hashtags_title_length CHECK (length(title) BETWEEN 1 AND 100),
    -- stored without the leading '#', so #Sunset and Sunset are one tag
    CONSTRAINT hashtags_title_no_hash CHECK (title NOT LIKE '#%')
);


-- ==================================================== direct children ======

-- Self-referencing: both columns point back at users.
CREATE TABLE follows (
    id           bigserial   PRIMARY KEY,
    follower_id  bigint      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    following_id bigint      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at   timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT follows_unique      UNIQUE (follower_id, following_id),
    CONSTRAINT follows_no_selffollow CHECK (follower_id <> following_id)
);

CREATE INDEX follows_following_idx ON follows (following_id);

CREATE TABLE posts (
    id          bigserial     PRIMARY KEY,
    user_id     bigint        NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    media_url   text          NOT NULL,
    caption     varchar(2200) NULL,
    -- deleting a place must not delete everyone's photos
    location_id bigint        NULL REFERENCES locations (id) ON DELETE SET NULL,
    created_at  timestamptz   NOT NULL DEFAULT now(),
    updated_at  timestamptz   NOT NULL DEFAULT now()
);

CREATE INDEX posts_user_created_idx ON posts (user_id, created_at DESC);
CREATE INDEX posts_location_idx     ON posts (location_id);


-- ==================================================== children of posts ====

CREATE TABLE comments (
    id         bigserial     PRIMARY KEY,
    user_id    bigint        NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id    bigint        NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    content    varchar(2200) NOT NULL,
    created_at timestamptz   NOT NULL DEFAULT now(),
    updated_at timestamptz   NOT NULL DEFAULT now()
);

CREATE INDEX comments_post_created_idx ON comments (post_id, created_at);

CREATE TABLE post_likes (
    id         bigserial   PRIMARY KEY,
    user_id    bigint      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id    bigint      NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT post_likes_unique UNIQUE (user_id, post_id)
);

-- the UNIQUE index leads with user_id, so counting a post's likes needs its own
CREATE INDEX post_likes_post_idx ON post_likes (post_id);

CREATE TABLE post_tags (
    id         bigserial    PRIMARY KEY,
    post_id    bigint       NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    user_id    bigint       NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    -- normalised 0..1 position of the tag on the photo
    x          numeric(5,4) NULL,
    y          numeric(5,4) NULL,
    created_at timestamptz  NOT NULL DEFAULT now(),
    CONSTRAINT post_tags_unique   UNIQUE (post_id, user_id),
    CONSTRAINT post_tags_x_range  CHECK (x BETWEEN 0 AND 1),
    CONSTRAINT post_tags_y_range  CHECK (y BETWEEN 0 AND 1),
    CONSTRAINT post_tags_xy_pair  CHECK ((x IS NULL) = (y IS NULL))
);

CREATE INDEX post_tags_user_idx ON post_tags (user_id);

CREATE TABLE post_hashtags (
    id         bigserial   PRIMARY KEY,
    post_id    bigint      NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    hashtag_id bigint      NOT NULL REFERENCES hashtags (id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT post_hashtags_unique UNIQUE (post_id, hashtag_id)
);

CREATE INDEX post_hashtags_hashtag_idx ON post_hashtags (hashtag_id);


-- ================================================= children of comments ====

CREATE TABLE comment_likes (
    id         bigserial   PRIMARY KEY,
    user_id    bigint      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    comment_id bigint      NOT NULL REFERENCES comments (id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT comment_likes_unique UNIQUE (user_id, comment_id)
);

CREATE INDEX comment_likes_comment_idx ON comment_likes (comment_id);


-- ==================================================== updated_at =========

-- DEFAULT now() only fires on INSERT. Without this trigger updated_at would
-- keep the insert time forever and quietly lie about when the row changed.
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_set_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER posts_set_updated_at
    BEFORE UPDATE ON posts
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER comments_set_updated_at
    BEFORE UPDATE ON comments
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
