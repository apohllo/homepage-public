---
title: Review of "Populating legal ontologies using semantic role labeling"
date: '2022-05-18T09:30:00Z'
lastmod: '2022-05-18T10:29:54Z'
draft: false
author: 185.172.85.177
---

The article entitled [Populating legal ontologies using semantic role labeling](https://aclanthology.org/2020.lrec-1.264/) published on LREC 2020 and later in JAIL discusses the application of Semantic Role Labeling approach for extracting structured (or semi-structured) information form provisions, EU directives in particular.

The article starts with the brief discussion of different approaches to ontology population and describes the SRL formalism. Then there are the following system described: **European Legal Taxonomy Syllabus**, **Eunomos** and **Legal-URN**.

The first system, ELTS, is a lightweight ontology used to compare and align legal terminology in several European countries. The system concentrated only on the concepts (i.e. rules were not concerned).

The second system (Eunomos) has two extensions. The first extension is concerned with linking the legislation with the contents of the ontology, by keeping links to the provisions, by structuring the provisions in XML format and by maintaining the cross-references. The second extension is concerned with the inclusion of rules in the ontology.

The third system (Legal-URN) has yet a different goal. It is based on business process modeling and extends the notation with deontic elements. It is devised as an extension to be applied in companies for providing legislation-based compliance for business process. This extension is based on **Hohfeldian** model of legal norms.

Then the article jumps to the description of the methodology applied for the extraction of **definitions** and **norms** from the EU legislation. The approach is based on a two or three-step procedure (depending on the type of extraction: 2 for definitions, 3 for norms): the text is normalized and it is parsed to the SRL formalism, the elements of the parsed sentence are mapped to a legal structure (e.g. Head -&gt; means (VBS) is used to detect the elements of a definition) and mapped to the final representation (in the case of norms). The paper discusses in detail only the first and the second step. There are no examples of rules for converting the second representation to the final one.

The system describes how to convert the following types of definitions:

-   regular definitions (e.g. **x means y**),
-   include/exclude definitions (e.g. **x including y and z**),
-   ostensive definitions (by example, e.g. **x such as y**),
-   referential definitions (e.g. **x defined in article y**).

It describes the following types of norms:

-   obligation (e.g. **x has to do y**),
-   right (e.g. **x shall be entitled to y**),
-   permission (e.g. **x is permitted to do y**),
-   power (e.g. **x may require y**).

The distinction between the different types of norms is not part of the article. The examples in that section justify my statement that the extracted data is semi-structured. The example concerned with a certificate, allows the system extracts **it** as an **active role** in the rule. This is strange, since I would expect a **certificate** to be extracted as the active role, the pronoun refers to. This is a serious limitation of the approach.

And it describes the following meta-norms:

-   legal effect (e.g. **an event x leads to an event y "automatically"**),
-   scope (e.g. **x can do y if/despite x is z**),
-   exception (e.g. **x can do y if z** or **x can do y**, **x cannot do y if z**),
-   hierarchy of norms (e.g. **rules concerning x are subject to regulations in y**),
-   rationale (e.g. **the purpose of x is y**).

The article is concluded with the evaluation of the approach. What is important: the number of converted (annotated) rules is pretty small. There are **224** sentences taken from Directive 95/46/EC and **267** sentences (the number is not reported directly in the article) from the Directive 98/5/EC. The first directive was used to create the norms, so the results are overly optimistic. Yet, it shows the limitation of the method, since it is impeded by the performance of the SRL parser. Depending on the type of argument, the results (lenient F1) range between 34 and 100%. Yet there are only three types of arguments with support &gt; 10. Obligation has 76%, Power has 85% (77% for strict evaluation) and Legal effect has 34%.

The second directive ("the test set") has much lower figures. Yet it is not described how the evaluation was performed - whether the directive was annotated first and the results were checked against the gold standard or the results were evaluated afterwards (in which case the results are invalid). Nevertheless, the values are in the range 0-100% (there's no aggregate result). The support is not reported, so it is impossible to filter the type of the argument by support. The macro-average lenient F1 is 53.3%.

Personal opinion: the article is important, since it identifies the different types of definitions and norms that appear in the legislation. The approach is lightweight, in the sense that the norms are not re-structured into fully formal representation, the arguments might be long pieces of text, which has to be further interpreted. Yet, as a result, sometimes the results are meaningless, like in the case of the pronoun, being the argument of a rule. The performance of the system is low, that it cannot be utilized in an automatic procedure. Even for manual curation, it would produce numerous false positives and false negatives. The system does not try to combine the outputs of the extraction in more meaningful representation, i.e. a concept that is extracted is not used as bias or restriction for an argument in the rules. For me, it is not known how the results should be further utilized in search, QA or legal modeling.
I think that methods base on question answering based on DNNs would be able to achieve better results (that's quite obvious), but they would be able to be applied without much annotation, since a general purpose QA dataset would be enough to achieve similar or even better results.
