describe("Home page", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});

describe("Product details page", () => {
  beforeEach(() => {
    cy.seedAndVisit(); 
  });

  it("should navigate to product details page", () => {
    cy.get(".products article").first().click(); 
    cy.url().should("include", "/products/"); 
    cy.get(".product-detail").should("be.visible"); 
  });
});
