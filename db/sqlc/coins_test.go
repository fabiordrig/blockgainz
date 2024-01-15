package db

import (
	"context"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestCreateCoin(t *testing.T) {
	arg := CreateCoinParams{
		Name:   "Bitcoin",
		Symbol: "BTC",
	}

	coin, err := testQueries.CreateCoin(context.Background(), arg)

	require.NoError(t, err)

	require.NotEmpty(t, coin)

	require.Equal(t, arg.Name, coin.Name)
	require.Equal(t, arg.Symbol, coin.Symbol)
}
