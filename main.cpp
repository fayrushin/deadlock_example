#include <iostream>
#include <mutex>
#include <thread>

int main(int argc, char *argv[]) {
  if (argc != 2) {
    std::cout << "Enter 1 to deadlock, 0 to run without deadlock" << std::endl;
    return 0;
  }

  bool deadlock = std::stoi(argv[1]);
  std::mutex mutex1;
  std::mutex mutex2;

  auto f1 = [](std::mutex &m1, std::mutex &m2) {
    std::lock_guard<std::mutex> lg1(m1);
    std::cout << "Lock m1" << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    std::lock_guard<std::mutex> lg2(m2);
    std::cout << "Lock m2" << std::endl;
  };

  std::cout << "Run thread1" << std::endl;
  std::thread thread1([&f1, &mutex1, &mutex2]() { f1(mutex1, mutex2); });
  std::cout << "Run thread2" << std::endl;
  std::thread thread2([&f1, &mutex1, &mutex2, deadlock]() {
    if (deadlock) {
      f1(mutex2, mutex1);
    } else {
      f1(mutex1, mutex2);
    }
  });

  thread1.join();
  std::cout << "Finish thread1" << std::endl;
  thread2.join();
  std::cout << "Finish thread2" << std::endl;
  int sleepFor = 5;
  std::cout << "Sleep for " << sleepFor << "s" << std::endl;
  std::this_thread::sleep_for(std::chrono::seconds(sleepFor));
  return 0;
}
