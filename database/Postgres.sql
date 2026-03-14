CREATE TYPE "reaction" AS ENUM (
  'like',
  'dislike'
);

CREATE TABLE "follows" (
  "following_user_id" long NOT NULL,
  "followed_user_id" long NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "users" (
  "id" long PRIMARY KEY,
  "username" varchar NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "posts" (
  "id" long PRIMARY KEY,
  "place_id" long NOT NULL,
  "user_id" long NOT NULL,
  "title" varchar,
  "body" text NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "places" (
  "id" long PRIMARY KEY,
  "name" varchar NOT NULL,
  "coordinates" geography NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "reactions" (
  "id" long PRIMARY KEY,
  "created_at" timestamp NOT NULL,
  "post_id" long NOT NULL,
  "user_id" long NOT NULL,
  "reaction" reaction NOT NULL
);

CREATE TABLE "comments" (
  "id" long PRIMARY KEY,
  "user_id" long NOT NULL,
  "post_id" long NOT NULL,
  "created_at" timestamp NOT NULL,
  "body" text NOT NULL
);

CREATE TABLE "photos" (
  "id" long PRIMARY KEY,
  "post_id" long NOT NULL,
  "storage_key" text NOT NULL,
  "file_size" integer NOT NULL,
  "mime_type" varchar NOT NULL,
  "metadata" jsonb,
  "created_at" timestamp NOT NULL
);

COMMENT ON COLUMN "posts"."body" IS 'Content of the post';

ALTER TABLE "follows" ADD FOREIGN KEY ("following_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "follows" ADD FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "posts" ADD CONSTRAINT "user_place" FOREIGN KEY ("place_id") REFERENCES "places" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "posts" ADD CONSTRAINT "user_posts" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "reactions" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "reactions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comments" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "photos" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;
