import hashlib, json

PATIENT_RECORDS = [
    {
        "patient_id": "P001",
        "name": "Ravi Kumar",
        "age": 45,
        "blood_type": "O+",
        "diagnosis": "Type 2 Diabetes",
        "medications": ["Metformin 500mg", "Glipizide 5mg"],
        "last_visit": "2025-03-10",
        "doctor_id": "Device_1",
        "notes": "HbA1c: 7.2%, BP: 130/85"
    },
    {
        "patient_id": "P002",
        "name": "Ananya Sharma",
        "age": 32,
        "blood_type": "B+",
        "diagnosis": "Hypertension",
        "medications": ["Amlodipine 5mg"],
        "last_visit": "2025-03-15",
        "doctor_id": "Device_1",
        "notes": "BP: 145/92, advised lifestyle changes"
    },
    {
        "patient_id": "P003",
        "name": "Suresh Reddy",
        "age": 60,
        "blood_type": "A+",
        "diagnosis": "Coronary Artery Disease",
        "medications": ["Aspirin 75mg", "Atorvastatin 40mg", "Bisoprolol 5mg"],
        "last_visit": "2025-03-18",
        "doctor_id": "Device_2",
        "notes": "Echo: EF 55%, follow-up in 3 months"
    }
]

def get_patient_message(patient_id: str) -> str:
    record = next((p for p in PATIENT_RECORDS if p["patient_id"] == patient_id), None)
    if not record:
        return f"No record found for {patient_id}"
    return json.dumps(record, indent=2)

def hash_record(message: str) -> bytes:
    return hashlib.sha256(message.encode()).digest()