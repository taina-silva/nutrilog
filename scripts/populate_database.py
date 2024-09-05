import json
import firebase_admin
from firebase_admin import credentials, firestore
import json

cred = credentials.Certificate("scripts/service_account_key_dev.json")
app = firebase_admin.initialize_app(cred)
client = firestore.client()

with open("assets/jsons/physical_activities.json") as f:
    data = json.load(f)

    types = data["types"]
    physical_activities = data["physical-activities"]

    docs = client.collection("physical-activities").list_documents()

    for doc in docs:
        doc.delete()

    doc_ref = client.collection("physical-activities").document("types")
    doc_ref.set({"types": types})

    for item in physical_activities:
        print(item)
        doc_ref = client.collection("physical-activities").document()
        doc_ref.set({"type": item["type"], "physical-activities": item["pA"]})

print("\nDone uploading physical activities data to firesore!\n")

with open("assets/jsons/nutritions.json") as f:
    data = json.load(f)

    types = data["types"]
    nutrition = data["nutrition"]

    docs = client.collection("nutrition").list_documents()

    for doc in docs:
        doc.delete()

    doc_ref = client.collection("nutritions").document("types")
    doc_ref.set({"types": types})

    for item in nutrition:
        print(item)
        doc_ref = client.collection("nutritions").document()
        doc_ref.set({"type": item["type"], "nutrition": item["food"]})

print("\nDone uploading nutrition data to firesore!\n")
