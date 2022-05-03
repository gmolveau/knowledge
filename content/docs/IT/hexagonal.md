Clean architecture by Robert "Uncle Bob" Martin https://www.oreilly.com/library/view/clean-architecture-a/9780134494272/ (2017)

+ example Architecture the Lost Years http://www.youtube.com/watch?v=WpkDN78P884 (2011)

Onion Architecture by Jeffrey Palermo http://jeffreypalermo.com/blog/the-onion-architecture-part-1/ (2008)

Hexagonal Architecture by Alistair Cockburn http://alistair.cockburn.us/Hexagonal+architecture (2005)

Domain-Driven Design by Eric Evans http://dddcommunity.org/book/evans_2003/ (2003)

Martin Fowler https://martinfowler.com/tags/domain%20driven%20design.html (2002)

---

reprend l'archi hexagonale,
tu peux partir du core, ce que tu veux que ta feature fasse
tu définis tes ports, ce qu'elle va exposer (les méthodes qu'elle va devoir implémenter), et ce dont elle va avoir besoin (les méthodes dont ton business va dépendre, pour récupérer des données etc)

une fois ça de définit, tu peux développer ton core, t'as pas besoin du reste, tu dev ton business t'as tout.

ensuite t'implémentes l'infra selon le port que t'as défini, qui va concrètement aller chercher les trucs en base ou faire des get ou je sais quoi par exemple

et tu peux dev la sortie, que ça soit une API qui appelle ton business (toujours en passant par les ports hein) ou un job ou un script

https://blog.octo.com/architecture-hexagonale-trois-principes-et-un-exemple-dimplementation/

---

https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/

https://www.qwan.eu/2020/08/20/hexagonal-architecture.html

https://netflixtechblog.com/ready-for-changes-with-hexagonal-architecture-b315ec967749

https://tpierrain.blogspot.com/2020/03/hexagonal-architecture-dont-get-lost-on.html

https://wkrzywiec.medium.com/ports-adapters-architecture-on-example-19cab9e93be7

https://alexgrover.me/posts/python-hexagonal-architecture

https://beyondxscratch.com/fr/2018/09/11/architecture-hexagonale-le-guide-pratique-pour-une-clean-architecture/

---

testing

https://gustavohenrique.net/2019/01/e2e-testing-using-docker-cypress-vuejs-golang-postgres/

https://beyondxscratch.com/2019/08/26/implementing-functional-tests-in-domain-driven-design-hexagonal-architecture-using-cucumber-domain-driven-testing/


--- misc

hexagonal
---------

2 parts : inside (domain / core / business) / outside
outside is made of 2 parts : user-side (primary / left-side / driver side / driving / user-interface) and server-side (secondary / right-side / driven-side / infrastructure)

doudou : appli + domain + infra

greg : driving + core + driven ?

user-side = cli / web / api / websocket / grpc

business = offers a SERVICE

tell vs told

appli tells the domain
the infra is told by the domain

1st. What makes it possible to run a user interface, whatever type of user interface it might be;
2nd. The system business logic, or application core, which is used by the user interface to actually make things happen;
3rd. Infrastructure code, that connects our application core to tools like a database, a search engine or 3rd party APIs.

flow of control = appli > domain > infra > domain > appli

To enter the Hexagon and interact with the domain, we talk to a port that we call "driver port" or "left-side port"

The domain code will then third-party systems (data stores, web APIs, etc)
to gather information or trigger side-effect by using one or more "driven ports" or "right-side ports".

A port is therefore an interface belonging to the Domain using business semantics
to express either requests that we address to our system (left-side port)
or external interactions that it performs along the way to achieve its goal (right-side port).

only the left-side infrastructure code knows the Domain actually

you need to keep all the business orchestration logic at the Domain level
and not to distribute it at the infrastructure code level.

I rather advise you to write acceptance tests in which you will include your concrete adapters and only stub their last-mile I/O.
write acceptance tests that cover your entire hexagon, except for the I/O at the border

Always go through the center of the hexagon, do not connect your right-side adapters to each other
Do not code YOUR domain logic or YOUR domain orchestration logic in your adapters

PORT (interface) = contract by the domain - belongs inside the business logic


---

dependency injection is cool :

In Go, this often takes the form of passing dependencies to constructors:

This technique works great at small scale, but larger applications can have a complex graph of dependencies,
resulting in a big block of initialization code that's order-dependent but otherwise not very interesting.

bah pour plein de raisons, déjà c'est moins chiant, mais surtout là t'es couplé à tes implem,
la moindre modif tu dois y retoucher, qd t'as full dépendances partout c'est relou et sur des gros projets tu deviens fou

There are a number of dependency injection frameworks out there. For Go, Uber's dig and Facebook's inject
both use reflection to do runtime dependency injection. Wire was primarily inspired by Java's Dagger 2

déléguer du taf au framework -> IoC (Inversion of Control)
(https://www.baeldung.com/inversion-control-and-dependency-injection-in-spring#what-is-inversion-of-control)

ce que tu délègues ici -> DI (Dependency Injection)

go : https://blog.golang.org/wire + https://github.com/google/wire + https://blog.drewolson.org/go-dependency-injection-with-wire

https://quii.gitbook.io/learn-go-with-tests/go-fundamentals/dependency-injection
