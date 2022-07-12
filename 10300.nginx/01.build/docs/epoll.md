# Epoll

通常来说，实现处理 tcp 请求，为一个连接一个线程，在高并发的场景，这种多线程模型与 Epoll 相比就显得相形见绌了。 epoll 是 linux2.6 内核的一个新的系统调用，epoll 在设计之初，就是为了替代 select ,  poll 线性复杂度的模型，epoll的时间复杂度为O(1), 也就意味着，epoll 在高并发场景，随着文件描述符的增长，有良好的可扩展性。

- select 和 poll 监听文件描述符list，进行一个线性的查找 O(n)
- epoll 使用了内核文件级别的回调机制 O(1)

下表展示了文件描述符的量级和 CPU 耗时

| Number of File Descriptors | poll() CPU time   |  select() CPU time  | epoll() CPU time|
| --------   | -----:  | :----:  | :----:  |
| 10      | 0.61  |   0.73     | 0.41|
| 100        |  2.9   |   3   | 0.42 |
| 1000        |    35    |  35  | 0.53 |
| 10000      |    990    |  930 | 0.66 |


cat /proc/sys/fs/epoll/max_user_watches

表示用户能注册到epoll实例中的最大文件描述符的数量限制。


