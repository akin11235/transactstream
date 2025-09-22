import os
import pandas as pd
from data import faker_generate

def test_generate_transaction_csv(tmp_path):
    # Use a temporary file path so we don't clutter the repo
    csv_file = tmp_path / "financial_transactions.csv"

    # Generate 100 transactions and save to CSV
    df = faker_generate.generate_transaction(100)
    df.to_csv(csv_file, index=False)

    # Check that the file was created
    assert csv_file.exists()

    # Load CSV and check shape and columns
    df_csv = pd.read_csv(csv_file)
    assert len(df_csv) == 100

    expected_cols = [
        "transaction_id", "customer_id", "customer_name", "email",
        "card_number", "merchant", "merchant_category", "amount",
        "currency", "transaction_type", "status", "country",
        "device", "timestamp", "is_fraud"
    ]
    assert all(col in df_csv.columns for col in expected_cols)
