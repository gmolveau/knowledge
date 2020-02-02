donc oui hexa tu veux séparer 
Appli
Domain
Infra

de base, tu dois avoir des modules fonctionnels

et pour ces modules fonctionnels, oui, ddd

et dans ton code, hexa

donc t'as un module authent, un module purchase, un module products, un module etc etc etc qui font des séparations fonctionnelles claires

et dans tes modules

t'as app/domain/infra

app -> your typical WS endpoint, ton API Rest que t'expose

domain -> ton business, la couche métier, appelé par l'app, qui peut appeler le repo et fait des trucs avec ce qu'il récupère 

infra -> tes repo, accès à la DB / services tiers / autres modules

en hexa tu isoles ton business du reste

si t'as lu clean code
tu comprends que c'est une pratique que tu dois avoir pour un peu tout, tu veux découpler au max
histoire que t'ais pas tout à refaire à chaque modif

on prend l'exemple de la search
bon bah que j'aille chercher dans elastic, solr, mongo, ou whatever, j'm'en branle je récupère des infos et j'en fais qq chose 
on prend l'exemple du purchase
bon bah je récupère un ID de product, un user, et derrière je vais persister le purchase dans couchbase, mais demain j'vais aussi envoyer une notif de facturation, après demain j'vais envoyer la notif sur un kafka pour l'analytics, etc
et tu veux pas que tout soit mêlé dans une fonction néantielle
t'as des trucs séparés et clairs
et pour organiser le tout
t'as ... des interfaces
& that's all, c'est ce qui te permet d'avoir chaque module indépendant, et un business découplé de son implémentation
