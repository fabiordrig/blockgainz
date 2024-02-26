include .env.local

db:
	@echo "Starting db..."
	@echo "Database started."
	docker run --name $(DB_CONTAINER) -e POSTGRES_USER= -e POSTGRES_PASSWORD=$(DB_PASSWORD) -p $(DB_PORT):5432 -d postgres

createdb:
	@echo "Creating database..."
	@echo "Database created."
	docker exec -it $(DB_CONTAINER) createdb -U $(DB_USER) -e $(DB_NAME)

dropdb:
	@echo "Dropping database..."
	@echo "Database dropped."
	docker exec -it $(DB_CONTAINER) dropdb -U $(DB_USER) -e $(DB_NAME)

create-migration:
	@echo "Creating migration..."
	migrate create -ext sql -dir db/migrations -seq $(NAME)
	@echo "Migration created."

migrate:
	@echo "Migrating database..."
	migrate -path db/migrations -database "postgres://$(DB_USER):$(DB_PASSWORD)@localhost:$(DB_PORT)/$(DB_NAME)?sslmode=disable" -verbose up
	@echo "Database migrated."

revert:
	@echo "Reverting database..."
	migrate -path db/migrations -database "postgres://$(DB_USER):$(DB_PASSWORD)@localhost:$(DB_PORT)/$(DB_NAME)?sslmode=disable" -verbose down $(REVERT_STEPS)
	@echo "Database reverted."

sqlc:
	@echo "Generating sqlc..."
	sqlc generate

test:
	@echo "Running tests..."
	go test -v -cover ./...

PHONY: db createdb dropdb migrate revert create-migration sqlc test
