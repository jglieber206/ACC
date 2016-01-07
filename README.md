# ACC
ACC app

ACC modeling originally came from the Google development process:

Introduction
Test Analytics allows you to efficiently construct an ACC model for your project. This ACC model, shorthand for Attributes-Components-Capabilities, will in many ways replace a conventional test plan. It's faster to write, can direct you toward missing coverage, and is the framework for calculating a risk surface map for your project.

For a moderately sized project, an initial ACC breakdown might take 20 minutes to an hour. In this time, you'll define the three parts of the ACC model for your project: Attributes, Components, and Capabilities.

Why ACC?
Many test plans suffer from one or more common problems:

Difficult to keep up-to-date and become obsolete
Written ad-hoc, leading to holes in coverage
Ignored after initial creation or review
Give little actionable data
Disorganized, difficult to consume all related information at once
In addition, we've found that when trying to utilize risk-based testing methodologies, a conventional test plan doesn't give a good visual map of the project -- there's no great place to start or end when determining risk, nor do they provide a good mechanism by which to visualize the risk.

ACC aims to solve that in a simple way. It's an easy-to-follow process that can be applied consistently to projects quickly. At the end of the process, you have a system of coherent and logically-related elements, in a form which is easy to digest.

What is ACC?
ACC consists of three different parts that define your system under test: Attributes, Components, and Capabilities. An easy way to think of each of these elements is by relating them to a part of speech relating to your project.

Attributes (adjectives of the system) are qualities and characteristics that promote the product and distinguish it from the competition; examples are "Fast", "Secure", "Stable", and "Elegant". A product manager could have a hand in narrowing down the list of Attributes for the system.
Components (nouns of the system) are building blocks that together constitute the system in question. Some examples of Components are "Firmware", "Printing", and "File System" for an operating system project, or "Database", "Cart", and "Product Browser" for an online shopping site.
Capabilities (verbs of the system) describe the abilities of a particular Component in order to satisfy the Attributes of the system. An example Capability for a shopping site could be "Processes monetary transactions using HTTPS". You can see that this could be a Capability of the "Cart" component when trying to meet the "Secure" Attribute. The most important aspect of Capabilities is that they are testable.
Defining Capabilities requires you to visit each intersection point between Attributes and Components; this often can lead to discovery of areas which otherwise may have gone unrecognized or untested in a conventional test plan. This could be as simple as assuring there is thought put into the security of an entire system (via the Attribute "Secure"), or details specific to your project when considered to specific characteristics you want your product to exhibit. It can also help assure consideration is given to all qualities are considered as new Capabilities are added to your product.
Read more here: https://code.google.com/p/test-analytics/wiki/AccExplained


postgres -D /usr/local/var/postgres
