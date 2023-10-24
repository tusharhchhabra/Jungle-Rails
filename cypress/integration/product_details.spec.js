/// <reference types="cypress" />

beforeEach(() => {
  cy.visit("/");
});

it("should navigate to the product detail page when a product is clicked", () => {
  cy.get("article").first().find("a").click();

  cy.url().should("include", "/products/");
  cy.get("h1").should("exist");
});
