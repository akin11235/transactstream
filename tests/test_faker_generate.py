import pandas as pd
from transactstream.faker import faker_generate

def test_generate_transaction_shape():
    # Generate 100 records
    df = faker_generate.generate_transaction(100)
    
    # Test: returns a DataFrame
    assert isinstance(df, pd.DataFrame)
    
    # Test: expected number of rows
    assert len(df) == 100
    
    # Test: expected columns
    expected_cols = [
        "transaction_id", "customer_id", "customer_name", "email",
        "card_number", "merchant", "merchant_category", "amount",
        "currency", "transaction_type", "status", "country",
        "device", "timestamp", "is_fraud"
    ]
    assert all(col in df.columns for col in expected_cols)
    
    # Test: fraud flag only contains 0 or 1
    assert df["is_fraud"].isin([0, 1]).all()
