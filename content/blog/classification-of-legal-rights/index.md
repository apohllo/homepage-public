---
title: Classification of legal rights
date: '2022-05-20T09:15:00Z'
lastmod: '2022-05-20T10:03:26Z'
draft: false
author: 185.172.85.177
---

The PhD thesis [Engineering Law-Compliant Requirements: the Nomos Framework](http://eprints-phd.biblio.unitn.it/230/) by Alberto Siena contains a very interesting classification of the legal rights.
In my [previous post](https://apohllo.pl/blog/review-of-populating-legal-ontologies-using-semantic-role-labeling), reviewing the article describing the application of SRL methods to the extraction of definitions and norms from laws, I have briefly mentioned that there are four types of norms: **obligation, right, permission and power**. Yet the description was not very elaborate. So I consulted the source of this classification, which is the PhD of Alberto Siena. I haven't read the full thesis yet, but it is a very interesting and very clear description of a proposed formalism used to model the legal rights.

The classification is based on the work of Hohfeld (1913). It introduces the following pairs of "rights" (written in quotes, since this is a technical term, which should not be associated with the regular meaning of a privilege):

-   **claim - duty**,
-   **privilege - noclaim**,
-   **power - liability**,
-   **immunity - disablity**.

Each pair of rights describes the same deontic situation from the perspective of opposite actors bound by the right. If **A has a claim against B**, then **B has a duty against A**. So it is not necessary to describe them separately.

Claim - duty
------------

This is the case of two actors, when one (B) has an obligation (duty) to do something for (A). So A has a claim against B - meaning that he expects, and the law supports that expectation, that B would fulfil the claim. E.g. A is a **patient** and B is a **doctor**. According to the Polish law, the doctor has to inform the patient about the outcomes of the medical examination of his body. So the **doctor** has a **duty** to **inform**, while the **patient** has a **claim** to **be informed**. The **support** given by law is usually carried out by sanction, by not fulfilling the claim. Yet these sanctions are not part of the relationship.

Privilege - noclaim
-------------------

This is the opposite of the previous relation, in the sense, that the **noclaim** party of the relationship is not supported by law, to fulfil an expectation from that party. But in general there might be no such expectation from the party. The relationship is more concerned with the **privilege** party - it has a **right** (in the normal sense) to do something, but the counterparty can not force the party to do so. E.g. if A is a **land owner** and B is some **local authority**, responsible for the territory, the land is a part of, if the local law allows that, A can build a house on his/her piece of land. Yet, the local authority cannot force the owner to do so. Thus, the owner has a **privilege** and the authority has **noclaim** against the owner.

As we see in that example, the noclaim party is less connected with the privileged party, than in the previous relationship, since there might be many subjects who might be interested in A using theirs privilege (or not using, which is covered by the same relationship): neighbors, family, etc. In most of the cases it is useless to name these subjects as the **noclaim** party to a particular privilege, so this seems to be a degraded element of the relationship.

Power - liability
-----------------

This relationship is a reflection of the **claim - duty** relationship, but it has a different **action** associated with it. In the previous case, the action was concerned with its own outcome (e.g. **patient being informed**), in that case the action is concerned with its **legal outcome**. So the power allows A to change the legal situation of B, while B has a liability against A, who can change their legal situation. E.g. if A is a **jury** and B is a **suspect**, the jury may judge, that the suspect is guilty. This action will change the legal position of the suspect, making them a convicted person.

Immunity - disability
---------------------

In that case, the relationship is a reflection of the **noclaim - privilege** relationship, but applied to the legal outcomes of actions. It is impossible for the **disabled** party to change the legal situation of the **immune subject**. E.g. if A is a **prosecutor** and B is a **judge**, in normal circumstances A cannot prosecute B. If B were not a judge, the prosecutor would have the **power** to do that. Once again, we see that this relationship is the opposite of the previous one.

Summary
-------

This classification of the legal rights seems very clear to me. The symmetry of the relationships provides simple structure to the rights.
