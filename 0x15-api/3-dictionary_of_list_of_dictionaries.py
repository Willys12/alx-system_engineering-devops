#!/usr/bin/python3
"""
Python3 script to fetch REST API for todo
lists of employees and save to JSON
"""

import json
import requests
import sys

if __name__ == '__main__':
    url = "https://jsonplaceholder.typicode.com/users"
    resp = requests.get(url)
    users = resp.json()

    users_dict = {}
    for user in users:
        user_id = user.get('id')
        username = user.get('username')
        todos_url = 'https://jsonplaceholder.typicode.com/users/{}/todos'.format(user_id)
        todos_resp = requests.get(todos_url)
        tasks = todos_resp.json()

        users_dict[user_id] = []
        for task in tasks:
            task_completed_status = task.get('completed')
            task_title = task.get('title')
            users_dict[user_id].append({
                "task": task_title,
                "completed": task_completed_status,
                "username": username
            })

    with open('todo_all_employees.json', 'w') as f:
        json.dump(users_dict, f)

