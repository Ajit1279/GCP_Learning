import base64
import json
import os
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials
PROJECT_ID = os.getenv('GCP_PROJECT')
PROJECT_NAME = f'projects/{PROJECT_ID}'

def stop_billing(data, context):
    if 'data' in data.keys():
        pubsub_data = base64.b64decode(data['data']).decode('utf-8')
        pubsub_json = json.loads(pubsub_data)
        cost_amount = pubsub_json['costAmount']
        budget_amount = pubsub_json['budgetAmount']
    else:
        cost_amount = data['costAmount']
        budget_amount = data['budgetAmount']
    if cost_amount <= budget_amount:
        print(f'No action necessary. (Current cost: {cost_amount})')
        return    
    if PROJECT_ID is None:
        print('No project specified with environment variable')
        return
    billing = discovery.build('cloudbilling', 'v1', cache_discovery=False, )
    projects = billing.projects()
    billing_enabled = __is_billing_enabled(PROJECT_NAME, projects)
    if billing_enabled:
        __disable_billing_for_project(PROJECT_NAME, projects)
    else:
        print('Billing already disabled')


def __is_billing_enabled(project_name, projects):
    """
    Determine whether billing is enabled for a project
    @param {string} project_name Name of project to check if billing is enabled
    @return {bool} Whether project has billing enabled or not
    """
    res = projects.getBillingInfo(name=project_name).execute()
    return res['billingEnabled']


def __disable_billing_for_project(project_name, projects):
    """
    Disable billing for a project by removing its billing account
    @param {string} project_name Name of project disable billing on
    @return {string} Text containing response from disabling billing
    """
    body = {'billingAccountName': ''}  # Disable billing
    res = projects.updateBillingInfo(name=project_name, body=body).execute()
    print(f'Billing disabled: {json.dumps(res)}')
