/// <reference types="cypress" />

beforeEach(() => {
  cy.visit("127.0.0.1:3000");
});

it("There are 2 products on the page", () => {
  cy.get(".products article").should("have.length", 2);
});
