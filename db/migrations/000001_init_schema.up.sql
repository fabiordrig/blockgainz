CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE "coins" (
  "coin_id" uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  "name" varchar UNIQUE NOT NULL,
  "symbol" varchar UNIQUE NOT NULL,
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz,
  "deleted_at" timestamptz
);

CREATE TABLE "transactions" (
  "transaction_id" uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  "coin_id" uuid NOT NULL,
  "quantity" decimal NOT NULL,
  "purchase_price" decimal NOT NULL,
  "purchased_at" timestamptz NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "updated_at" timestamptz,
  "deleted_at" timestamptz
);

CREATE INDEX ON "transactions" ("coin_id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("coin_id") REFERENCES "coins" ("coin_id");
