import random
import uuid
from datetime import datetime, timedelta
from faker import Faker
import pandas as pd

fake = Faker()

def generate_transaction(n=1000):
    data = []
    start_date = datetime(2023, 1, 1)
    
    for _ in range(n):
        txn_time = start_date + timedelta(seconds=random.randint(0, 365*24*60*60))
        customer_id = uuid.uuid4().hex[:8]
        
        record = {
            "transaction_id": uuid.uuid4().hex,
            "customer_id": customer_id,
            "customer_name": fake.name(),
            "email": fake.email(),
            "card_number": fake.credit_card_number(card_type=None),
            "merchant": fake.company(),
            "merchant_category": random.choice(["Retail", "Travel", "Food", "Electronics", "Entertainment", "Healthcare"]),
            "amount": round(random.uniform(5, 5000), 2),
            "currency": random.choice(["USD", "CAD", "EUR", "GBP"]),
            "transaction_type": random.choice(["Purchase", "Withdrawal", "Transfer", "Payment"]),
            "status": random.choice(["Success", "Failed", "Pending"]),
            "country": fake.country(),
            "device": random.choice(["Mobile", "Web", "POS", "ATM"]),
            "timestamp": txn_time.strftime("%Y-%m-%d %H:%M:%S"),
            "is_fraud": random.choices([0, 1], weights=[0.98, 0.02])[0]  # 2% fraud
        }
        data.append(record)
    
    return pd.DataFrame(data)


# Generate sample
df = generate_transaction(10000)

# Save to CSV for Bronze layer ingestion
df.to_csv("data/financial_transactions.csv", index=False)
print("Generated financial_transactions.csv with", len(df), "records")
