This is a simple survey builder
===============================

## Abilities

* Create Questions
* Save Questions
* Delete Questions
* Order Questions
* Generate a form
* Publish a form


* Submit a form
* Compute Score


scripts:
VERBOS=1 QUEUE=mailer rake resque:work
VERBOS=1 QUEUE=score_calculation rake resque:work

