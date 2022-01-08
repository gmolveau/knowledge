Docker does not has an OS in its containers. In simple terms, a docker container image just has a kind of filesystem snapshot of the linux-image the container image is dependent on.

The container-image includes some basic programs like bash-shell, vim-editor etc to facilitate developer to work easily with the docker image. Also, docker images can include pre-installed dependencies like nodeJS, redis-server etc as we can find on docker hub.

Docker behind the scene uses the host OS which is linux itself to run its containers. The programs included in linux-like filesystem snapshot that we see in form of docker containers actually runs on the host OS in isolation.

The container-images may sound like different linux distros but they are the filesystem snapshot of those distros. All Linux distributions are based on the same kernel. They differ in the programs, tools and dependencies that they ships with.

---

Since all Linux distributions run the same (yup, it's a bit simplified) Linux kernel and differ only in userland software, it's pretty easy to simulate a different distribution environment - by just installing that userland software and pretending it's another distribution. Being specific, installing CentOS container inside Ubuntu OS will mean that you will get the userland from CentOS, while still running the same kernel, not even another kernel instance.

So lightweight virtualization is like having isolated compartments within same OS. Au contraire real virtualization is having another full-fledged OS inside host OS. That's why docker cannot run FreeBSD or Windows inside Linux.

If that would be easier, you can think docker is kind of very sophisticated and advanced chroot environment.

---

https://github.com/GoogleContainerTools/distroless/blob/master/base/README.md
https://github.com/GoogleContainerTools/distroless/blob/master/examples/go/Dockerfile

https://hackernoon.com/distroless-containers-hype-or-true-value-2rfl3wat
https://timberry.dev/posts/building-go-containers-cloud-run/

https://enix.io/fr/blog/cherie-j-ai-retreci-docker-part2/
https://blog.depa.do/post/small-secure-docker-golang
