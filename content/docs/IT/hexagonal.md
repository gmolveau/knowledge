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
