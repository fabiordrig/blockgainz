-- name: CreateCoin :one
INSERT INTO coins (name, symbol) VALUES ($1, $2) RETURNING *;

-- name: GetCoins :many
SELECT * FROM coins ORDER BY name
LIMIT $1 OFFSET $2;
