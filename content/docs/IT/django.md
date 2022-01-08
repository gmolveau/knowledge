# Django

https://developer.mozilla.org/fr/docs/Learn/Server-side/Django

https://docs.djangoproject.com/en/4.0/intro/tutorial01/

https://github.com/nickjj/docker-django-example

https://news.ycombinator.com/item?id=29472349

```
Django has allowed me to enjoy some side entrepreneurship. I have released three products as a solo part time dev that I would never have been able to do in a reasonable time using Java/Spring (my strongest stack). My first project went nowhere, but the second generated 1k+ a month and sold for 50k, and the third one is following a similar trajectory.

My advice - keep it simple

- function based views

- centralize access to the ORM (avoid fat models, use a service layer)

- responsive bootstrap template with crispy forms

- minimal js

- 12 factor type setup - django-environ or similar

- be aware of n+1 select problem (I use django debug toolbar but looking into django-zen-queries)

- plop it on heroku, AWS lightsail, Digital Ocean or if containerizing use AWS Fargate

- avoid celery unless you are at a scale you need it - use django-cron, django-db-queue or similar

- use a managed database and managed email service

I have had zero scalability problems. People say Django is slow but it handled 10k active users on a small EC2 instance without any issues (static stuff served via cloudfront)
```
