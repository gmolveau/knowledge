Courses
=======

- https://testwithgo.com/#buy
- https://www.calhoun.io/moving-towards-domain-driven-design-in-go/?__s=gqaghnpg3ivlqw57uu4x
- https://www.calhoun.io/courses
- https://lets-go.alexedwards.net/#packages
- https://ednsquare.com/story/learn-go-beginners-guide-to-learn-golang-from-scratch-------gTmFx6 (free)
- https://quii.gitbook.io/learn-go-with-tests/

- https://rytisbiel.com/2021/03/06/darker-corners-of-go/


Clean Architecture / Hexagonal Architecture
===========================================

- https://blog.octo.com/architecture-hexagonale-trois-principes-et-un-exemple-dimplementation/

- Building Hexagonal Microservices with Go
    - le code : https://github.com/tensor-programming/hex-microservice/tree/part-1
        - bien checker la branche sur github, ya part 1, 2 et 3
    - Part 1 https://youtu.be/rQnTtQZGpg8
    - Part 2 https://youtu.be/xUYDkiPdfWs
    - Part 3 https://youtu.be/QyBXz9SpPqE

- https://medium.com/@eminetto/clean-architecture-using-golang-b63587aa5e3f
    + https://github.com/eminetto/clean-architecture-go

- https://eltonminetto.net/en/post/2020-07-06-clean-architecture-2years-later/
    + https://github.com/eminetto/clean-architecture-go-v2

- https://github.com/err0r500/go-realworld-clean

- https://threedots.tech/post/introducing-clean-architecture/

- https://github.com/ThreeDotsLabs/wild-workouts-go-ddd-example

- https://github.com/AkbaraliShaikh/denti

Go Design Patterns
==================

- Part 1 - The Decorator Pattern - https://youtu.be/F365lY5ECGY?list=WL
- Part 2 - Generator Pattern and Observer Pattern - https://youtu.be/Rb8s0zw1SNM
- Part 3 - Factory and Abstract Factory Pattern - https://youtu.be/-1xgg7yUlUc?list=WL

Concurrency
===========

- https://gobyexample.com/goroutines pour apprendre
- https://go-tour-fr.appspot.com/concurrency pour apprendre + exos
- https://youtu.be/cN_DpYBzKso conference Rob Pike - 'Concurrency Is Not Parallelism'
- https://www.alexsears.com/2019/10/fun-with-concurrency-in-golang/
- https://madeddu.xyz/posts/go-async-await/
- https://begriffs.com/posts/2020-03-23-concurrent-programming.html
- https://medium.com/rungo/achieving-concurrency-in-go-3f84cbf870ca
- https://youtu.be/LvgVSSpwND8
- https://youtu.be/3atNYmqXyV4

- RWMutex
- https://dev.to/wagslane/golang-mutexes-what-is-rwmutex-for-57a0
- https://medium.com/@anto_rayen/understanding-locks-rwmutex-in-golang-3c468c65062a
- https://medium.com/golangspec/sync-rwmutex-ca6c6c3208a0
- https://www.alexedwards.net/blog/understanding-mutexes
- https://stackoverflow.com/questions/19148809/how-to-use-rwmutex-in-golang

- https://www.youtube.com/watch?v=f6kdp27TYZs Google I/O 2012 - Go Concurrency Patterns by Rob Pike
- https://youtu.be/QDDwwePbDtw Google I/O 2013 - Advanced Go Concurrency Patterns by Sameer Ajmani

- a voir la qualité >
    - https://dev.to/dannypsnl/testing-in-go-35ei
    - https://dev.to/quii/learn-go-by-writing-tests--m63
    - https://dev.to/gypsydave5/learn-go-by-writing-tests-concurrency--2ebk
    - https://dev.to/jankaritech/demonstrating-tdd-test-driven-development-in-go-27b0

- https://www.jernejsila.com/2017/12/23/error-handling-concurrent-programs-golang/
- https://golangcode.com/errors-in-waitgroups/
- https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/

Unit testing
============

- https://golang.org/pkg/net/http/httptest/#NewRequest

- https://dev.to/ilyakaznacheev/how-i-write-my-unit-tests-in-go-quickly-4bd5

- https://ednsquare.com/story/golang-the-essential-guide-to-unit-testing-in-golang------0HkRA4


MISC
====

```bash
go list -f "{{if .CgoFiles}}{{.ImportPath}}{{end}}" $(go list -f "{{.ImportPath}}{{range .Deps}} {{.}}{{end}}")
```

A TRIER
=======

- https://github.com/eminetto/clean-architecture-go-v2 [ok]

    api/ (left-side)
    api/presenter (interessant a garder pour pas oublier de refaire une struct de prez)
    cmd/ (left-side)
    pkg/password (interessant a garder)

    usecase/user/interface - interessant car decouplage writer / reader CQRS

    usecase/book/inmem - interessant implementation temporaire pour fake

    implementation DDD avec use-case - peut etre interessant pour reference plus tard

    makefile avec mockgen de call et autres fonctions utiles

    docker-compose complet avec prometheus + mysql + grafana mais il manque son app

session based cookie auth

- https://stackoverflow.com/questions/15374374/is-there-a-go-framework-or-package-that-provides-canned-user-authentication-supp
- https://curtisvermeeren.github.io/2018/05/13/Golang-Gorilla-Sessions.html
- https://github.com/lpar/pasetosession/blob/trunk/example/main.go
- https://astaxie.gitbooks.io/build-web-application-with-golang/content/en/06.1.html
- https://www.sohamkamani.com/golang/session-based-authentication/
- https://www.calhoun.io/securing-cookies-in-go/
- https://gowebexamples.com/sessions/
- https://stackoverflow.com/questions/35252253/golang-session-based-authentication
- https://stackoverflow.com/questions/63212476/is-it-a-good-practice-to-store-auth-session-in-the-database
- https://auth0.com/docs/sessions/cookies

https://dev.to/he110/circuitbreaker-pattern-in-go-43cn


- https://bitfieldconsulting.com/golang/how
- https://gianarb.it/blog/golang-mockmania-cli-command-with-cobra
- https://betterprogramming.pub/my-ultimate-makefile-for-golang-projects-fcc8ca20c9bb
