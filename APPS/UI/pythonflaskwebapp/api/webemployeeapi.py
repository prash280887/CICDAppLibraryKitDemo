import flask
from flask import Flask, request, jsonify
#from azure.cosmos import CosmosClient, PartitionKey
from datetime import datetime
import os
import logging

# Initialize Flask app
app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Azure Cosmos DB configuration
COSMOS_ENDPOINT = os.getenv("COSMOS_ENDPOINT", "https://localhost:8081/")
COSMOS_KEY = os.getenv("COSMOS_KEY", "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4OH+lsSMaO7DdkQMA==")
DATABASE_NAME = "EmployeeDB"
CONTAINER_NAME = "Employees"

# Initialize Cosmos DB client (singleton)
#cosmos_client = CosmosClient(COSMOS_ENDPOINT, COSMOS_KEY)
#database = cosmos_client.get_database_client(DATABASE_NAME)
#container = database.get_container_client(CONTAINER_NAME)



@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "healthy"}), 200

@app.route('/employees', methods=['GET'])
def get_employees():
    """Retrieve all employees"""
    try:
        # query = "SELECT * FROM c"
        # items = list(container.query_items(query=query, enable_cross_partition_query=True))
        items = [{"Id" : "1", "Name": "john", "Email": "john@gmail.com"}]  # Placeholder for fetched items
        return jsonify(items), 200
    
    except Exception as e :
        logger.error(f"Error fetching employees: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route('/employees/<employee_id>', methods=['GET'])
def get_employee(employee_id):
    """Retrieve a specific employee by ID"""
    try:
        
        items = [{"Id" : "1", "Name": "john", "Email": "john@gmail.com"}] 
        item = next((emp for emp in items if emp["Id"] == employee_id), None)
       # item = container.read_item(item=employee_id, partition_key=employee_id)
        return jsonify(item), 200
    
    except Exception as e:
        logger.error(f"Error fetching employee: {str(e)}")
        return jsonify({"error": "Employee not found"}), 404

@app.route('/employees', methods=['POST'])
def create_employee():
    """Create a new employee"""
    try:
        data = request.get_json()
        employee = {
            "id": data.get("id"),
            "name": data.get("name"),
            "email": data.get("email"),
            "department": data.get("department"),
            "createdAt": datetime.utcnow().isoformat()
        }
        container.create_item(body=employee)
        return jsonify(employee), 201
    except Exception as e:
        logger.error(f"Error creating employee: {str(e)}")
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)