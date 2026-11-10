from locust import HttpUser, task, between

class DoSLoginUser(HttpUser):
    wait_time = between(0.1, 0.3)  # simulate aggressive attacker

    @task
    def login(self):
        self.client.post(
            "/login",
            json={
                "username": "admin",
                "password": "admin123"
            }
        )
