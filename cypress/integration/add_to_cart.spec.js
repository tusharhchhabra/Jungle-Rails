/// <reference types="cypress" />

beforeEach(() => {
  cy.visit("/");
});

it("should add a product to cart and increase cart size", () => {
  cy.get(".nav-link").contains("My Cart (0)");

  cy.get("article")
    .first()
    .find("button")
    .contains("Add")
    .click({ force: true });

  cy.get(".nav-link").contains("My Cart (1)");
});
