import concurrent.futures
import math
import logging
import sys
import threading

loggers = {}


def get_logger(name):
    if name in loggers:
        return loggers[name]
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)
    fmt = '%(asctime)s - %(threadName)s - %(levelname)s - %(message)s'
    formatter = logging.Formatter(fmt)

    
    fh = logging.FileHandler(name + ".log", "w")
    fh.setFormatter(formatter)
    logger.addHandler(fh)

    loggers[name] = logger
    return loggers[name]


PRIMES = [
    112272535095293,
    112582705942171,
    112272535095293,
    115280095190773,
    115797848077099,
    1099726899285419,
    1299709,              
    15485863,             
    32416190071,          
    982451653,            
    776531401,            
    1234567891,           
    1000000007,           
    1000000009,           
    2147483647,           
    1013                 
]

def is_prime(n):
    logger = get_logger(threading.current_thread().name)
    logger.info("start {}*".format(n))
    if n % 2 == 0:
        logger.info("end1 {}*".format(n))
        return False

    sqrt_n = int(math.floor(math.sqrt(n)))
    for i in range(3, sqrt_n + 1, 2):
        if n % i == 0:
            logger.info("end2 {}*".format(n))
            return False
    logger.info("end3 {}*".format(n))
    return True


def main():
    with concurrent.futures.ThreadPoolExecutor(2, "thread") as executor:
        for number, prime in zip(PRIMES, executor.map(is_prime, PRIMES)):
            print('%d is prime: %s' % (number, prime))


main()

print("-----")

with open("thread_0.log", "r") as f:
    print(f.read())

print("-----")

with open("thread_1.log", "r") as f:
    print(f.read())
